#include "feature_extraction.h"

void read_data(uint8_t* data_array,uint8_t* counter1)
{
       //printf("\r\nIN"); 
       while((*counter1)<=3){
          data[row][column] |= (data_array[*counter1]&0xFF)<<((3-(*counter1))*8); 
          (*counter1)++;
       }

       //receive an integer number                      
        (*counter1) = 0;
        column++;
        
        //receive a row
        if(column>8)
        {
        // printf("\r\nGET NEW ROW\r\n");    
          //printf("\r\n%d,%d:%dGNR\r\n",row,column,data[row][0]); 
          column = 0;
          row++;
          //receive 2 seconds
          if(row==128)
          {
           printf("\r\nGET NEW BATCH\r\n");    
         //  printf("Int is %d\r\n",data[127][0]);
                                    
           //Signal feature extraction
           feature_extract();
           //request next window
   
           printf(":\r>\n"); 
           row=0;
           nrf_delay_ms(500);
          }
        }
}

void read_parameters(uint8_t* data_array,uint8_t* counter1){
    //printf("\r\nREAD PARA\r\n");
    int data_buffer=0;
    while(*counter1<=3){
        data_buffer|= (data_array[*counter1]&0xFF)<<((3-(*counter1))*8);
        (*counter1)++;
     }
        if(row==0){
          step_depth[column] = *((float*)(&data_buffer)); 
          //printf("\n%d:%f",column,step_depth[column]);
        }
        else if(row>=1 && row<=9){   
             thresholds[row-1][column] = *((float*)(&data_buffer)); 
             //if(row-1==7){printf("\n%d:%f",row-1,thresholds[row-1][column]);}       
        }
        else if(row>=10 && row<=18){   
             mask[row-10][column] = *((float*)(&data_buffer));
             //if(row-1==7){printf("\n%d:%f",row-1,thresholds[row-1][column]);}       
        }
        else if(row>=19 && row<=27){   
             lda_info[row-19][column] = *((float*)(&data_buffer));
             // printf("\n%d,%d:%f",row-19,column,lda_info[row-19][column]);
             //if(row-12==2 ||row-12==5 ||row-12==6){printf("\n%d:%f",row-12,ldas[row-12][column]);}       
        }
        else if (row==28 && column==0){
          dtth =  *((float*)(&data_buffer));
            printf("dtth %f\r\n",dtth);
           //column=9;
          
        }
        else if (row==28 && column==1){
          TG = *((float*)(&data_buffer));
          printf("TG %f\r\n",TG);
          column=9;
          }


        (*counter1) = 0;
        column++;
        //receive a row
        if(column>8){
          column = 0;
          row++;
          //printf("\r\nGET 9\r\n");       
          if(row==1){
           //printf("\r\nGET DEPTH\r\n");   
          }    
          else if(row==10){
                for(int i=0;i<9;i++){
          printf("T: %f\r\n",thresholds[7][i]);
          }
           //printf("GET THS \r\n");
          
          }    
          else if(row==19){
           //printf("GET MASK\r\n");
           
          }
          else if(row==28){

          for(int i=0;i<9;i++){
          //printf("W: %f\r\n",lda_info[0][i]);
          }
          

          }
          else if(row==29){

         
          
            parameter_flag=0;
            data_flag=1;
            (*counter1) = 0;
            row=0;
            
            printf("GET ALL PARAMETERS\r\n");
            nrf_delay_ms(500);          
          }
        }      
}
                      



void feature_extract()
{
  static uint8_t batch_counter=1;

  struct freq_info my_freq[sensors];
  float32_t means[sensors] = {0};
  float32_t smoothness[sensors] = {0};
  float32_t shift[sensors] = {0};
  float32_t counts[sensors] = {0};
  float32_t depth[sensors] = {0};
  float32_t entropy[sensors] = {0};
  uint32_t counter=0;
  float32_t result=0;
  uint8_t FoG = 0;

 
  printf("\r\nThis is %d window \r\n",batch_counter);
  get_mean(means);
  // get interval, counts and depth
  uint32_t now = app_timer_cnt_get();
  get_interval(shift,counts,depth);
  counter = app_timer_cnt_get();
  counter = counter-now;
  //printf("C1 is %d\r\n",counter);
 
  // get features in frequency domain
  nrf_gpio_pin_toggle(LED_2);
  now = app_timer_cnt_get();
  get_freq(my_freq,means);
  counter = app_timer_cnt_get();
  counter = counter-now;
  //printf("C2 is %d\r\n",counter);

  printf("dominant frequency is %d\r\n",my_freq[1].dominant_freq);
  printf("sumLoco is %f\r\n",my_freq[1].sumLoco);
  printf("sumFreeze is %f\r\n",my_freq[1].sumFreeze);
  printf("FI is %f\r\n",my_freq[1].freezingIndex);

 
  nrf_gpio_pin_toggle(LED_3);
  
  now = app_timer_cnt_get();
  get_smoothness(smoothness);
  counter = app_timer_cnt_get();
  counter = counter-now;
 //printf("C3 is %d\r\n",counter);
  batch_counter++;

  // Thresholding check
  for(int sensor=0;sensor<sensors;sensor++){
    //only use sensor in channel 2
    if(sensor==1){
      //stop detector
      if(thresholds[7][sensor]!=0){
         printf("sumAll threshold is %f\r\n",thresholds[7][sensor]);
         if(my_freq[sensor].sumFreeze<=thresholds[7][sensor]){ 
          thresholds_Flag=1;
        }
      }
      //FI detector      
      if(thresholds[6][sensor]!=0){
         printf("FI threshold is %f\r\n",thresholds[6][sensor]);
         if( my_freq[sensor].freezingIndex<=thresholds[6][sensor]){
          thresholds_Flag=1;
        }
      }
      //high frequency detector      
      if(thresholds[5][sensor]!=0){
         printf("DF threshold is %f\r\n",thresholds[5][sensor]);
         if( my_freq[sensor].dominant_freq<=thresholds[5][sensor]){
          thresholds_Flag=1;
        }
      }

      //step detector      
      if(thresholds[0][sensor]!=0){
        printf("shift threshold is %f\r\n",thresholds[0][sensor]);
       if(my_freq[sensor].sumLoco>=thresholds[0][sensor]){
         thresholds_Flag=1;
        }
      }
    }
    

  }

  if(thresholds_Flag==1){
    FoG=0;
  }
  else{
    for(int sensor=0;sensor<sensors;sensor++){
       result = result+lda_info[0][sensor]*shift[sensor];
       result = result+lda_info[1][sensor]*depth[sensor];
       result = result+lda_info[2][sensor]*counts[sensor];
       result = result+lda_info[3][sensor]*entropy[sensor];
       result = result+lda_info[4][sensor]*my_freq[sensor].sumLoco;
       result = result+lda_info[5][sensor]*my_freq[sensor].dominant_freq;
       result = result+lda_info[6][sensor]*my_freq[sensor].freezingIndex;
       result = result+lda_info[7][sensor]*my_freq[sensor].sumFreeze;
       result = result+lda_info[7][sensor]*smoothness[sensor];     
    } 

    if(TG==0){
      FoG = result<=dtth ? 1:0;
    }else{
      FoG = result>=dtth ? 1:0;
    }
  }

  nrf_delay_ms(500);
  nrf_gpio_pin_toggle(LED_4);
  printf("result is %d\r\n",FoG);

}

/**
This function is used to get the mean of test data
*/
void get_mean(float32_t* means)
{
	for(uint8_t i=0;i<sensors;i++)
	{
		for(uint8_t j=0;j<windowsize;j++)
		{
			 means[i]+=data[j][i];
		}
                means[i] = means[i]/windowsize;
	}

}

/**
This function is used to get the smoothness of test data
*/
void get_smoothness(float32_t* smoothness)
{
	for(uint8_t i=0;i<sensors;i++)
	{
		for(uint8_t j=1;j<windowsize;j++)
		{
			 smoothness[i]+=(data[j][i]-data[j-1][i])*(data[j][i]-data[j-1][i]);
		}
               smoothness[i] = smoothness[i]/windowsize;
	}

}
/**
This function is used to get the portion of test data
*/
void get_portion(float32_t* means,float32_t* portion)
{
        uint8_t counter=0;
	for(uint8_t i=0;i<sensors;i++)
	{
                if(mask[8][i]==1)
                {
                  for(uint8_t j=0;j<windowsize;j++)
                  {
                           if(data[j][i]>means[sensors]){
                           counter++;
                           }
                  }
                  portion[i] = counter/windowsize;
                }		
	}

}

/**
TODO:: This function is used to get the sample entropy of test data
*/
void get_entropy(float32_t* entropy)
{


}
/**
This function will be used to extract interval from data
*/
void get_interval(float32_t* shift,float32_t* counts,float32_t* depth){
  low_pass();
  for(int sensor=0;sensor<sensors;sensor++){
    //if anyone is selected
   if(!(mask[0][sensor]==0 && mask[1][sensor]==0 && mask[1][sensor]==0)){
     float32_t diff=0;
     uint8_t  count=0;
     uint8_t     p1=0;
     uint8_t     p2=0;
     uint8_t     I1=0;
     uint8_t  b_counts=0;
     float32_t max_value=0;
     float32_t min_value=0;
  
      // get depth
       for(int i=0;i<windowsize;i++){        
          if(LP_data[i][sensor]>max_value)
             max_value = LP_data[i][sensor];
          if(LP_data[i][sensor]<min_value)
             min_value = LP_data[i][sensor];
       }
       depth[sensor] = max_value-min_value;

    // get interval 
     for(int i=0;i<windowsize-1;i++){
        if(LP_data[i+1][sensor]>LP_data[i][sensor]){
          p1=i+1;
          p2=i+1;
        }
        else{
          if(i==windowsize-1)
            I1=0;
          else if(LP_data[p2][sensor]-LP_data[p2][sensor]>step_depth[sensor]){
            I1=p2;
            count=I1;
            break;
          }
          else
            p2=i+1;
        }
     }
      int I2=I1;
     
      p1=count;
      p2=count;

      for(int i=0;i<windowsize-1;i++){
        if(LP_data[i+1][sensor]>LP_data[i][sensor]){
          p1=i+1;
          p2=i+1;
        }
        else{
          if(i==windowsize-1)
            I2=I1;
          else if(LP_data[p2][sensor]-LP_data[p2][sensor]>step_depth[sensor]){
            I2=p2;
            break;
          }
          else
            p2=i+1;
        }
     }       

      if(I1==1 && I2==1)
          shift[sensor] = -10;
      else{
         shift[sensor] = I2-I1 < 0 ? I1-I2 : I2-I1;
      }
          
      //count bottoms
   
      p1=0;
      p2=0;

      for(int i=0;i<windowsize-1;i++){
          if(LP_data[i+1][sensor]>LP_data[i][sensor]){
            p1=i+1;
            p2=i+1;
          }
          else{
            if(i==windowsize-1)
              I2=1;
            else if(LP_data[p2][sensor]-LP_data[p2][sensor]>step_depth[sensor]){
              I2=p2;
              b_counts=b_counts+1;
              p1=i+1;
              p2=i+1;
          
            }
            else
              p2=i+1;
          }
       }  
       counts[sensor]= b_counts;
}

}
}




/**
This function is used to get the frequency information from test data
*/

void get_freq(struct freq_info* my_freq,float32_t* means)
{
        for(int sensor=0;sensor<sensors;sensor++)
        {
          // This part of code is used to get 32 FFT components 
          float32_t m_fft_input_f32[FFT_TEST_COMP_SAMPLES_LEN]={0};             //!< FFT input array. Time domain.
          float32_t m_fft_output_f32[FFT_TEST_OUT_SAMPLES_LEN]={0};             //!< FFT output data. Frequency domain.
          int dominant_index=0;
          float32_t t=0;
            
          for(int i=0;i<256;i=i+2)
          {
                  m_fft_input_f32[i] = data[i/2][sensor]-means[sensor]; //real
                  m_fft_input_f32[i+1] = 0;  //img
          }
        
          fft_process(m_fft_input_f32,
                      &arm_cfft_sR_f32_len128,
                      m_fft_output_f32,
                      FFT_TEST_OUT_SAMPLES_LEN);
          // band energy extraction
          // Calculating energy  
          for(int i=0;i<SR;i++)
          {
             m_fft_output_f32[i] = m_fft_output_f32[i]*m_fft_output_f32[i]/windowsize;
             if(i>=loco_l && i<=loco_h)
                my_freq[sensor].sumLoco += m_fft_output_f32[i];
             if(i>=freeze_l && i<=freeze_h)
                my_freq[sensor].sumFreeze += m_fft_output_f32[i];
             if(i>=freeze_l && i<=31)
                my_freq[sensor].sumHP += m_fft_output_f32[i];
          }
          my_freq[sensor].sumLoco = ((my_freq[sensor].sumLoco)-(m_fft_output_f32[loco_l]+m_fft_output_f32[loco_h])/2)/SR;
          my_freq[sensor].sumFreeze = ((my_freq[sensor].sumFreeze)-(m_fft_output_f32[freeze_l]+m_fft_output_f32[freeze_h])/2)/SR;
          // FI
          my_freq[sensor].freezingIndex = (my_freq[sensor].sumFreeze)/(my_freq[sensor].sumLoco);
          my_freq[sensor].sumFreeze =  my_freq[sensor].sumFreeze + my_freq[sensor].sumLoco;
           // dominant frequency
           for(int i=0;i<SR;i++)
           {        
              if(m_fft_output_f32[i]>t)
              {
                 t = m_fft_output_f32[i];
                 dominant_index = i;
              }
           }
           my_freq[sensor].dominant_freq = dominant_index;

        }
    
}


static void fft_process(float32_t *                   p_input,
                        const arm_cfft_instance_f32 * p_input_struct,
                        float32_t *                   p_output,
                        uint16_t                      output_size)
{
    // Use CFFT module to process the data.
    arm_cfft_f32(p_input_struct, p_input, m_ifft_flag, m_do_bit_reverse);
    // Calculate the magnitude at each bin using Complex Magnitude Module function.
    arm_cmplx_mag_f32(p_input, p_output, output_size);
}

/**
This function will be 5 order IIR butterworth low pass filter
*/
void low_pass(){
  float a[6] = {1,-2.4744,2.8110,-1.7038,0.5444,-0.0723};
  float b[6] = {0.0033,0.0164,0.0328,0.0328,0.0164,-0.0033};
  
  for(int i=0;i<sensors;i++){
    for(int j=0;j<windowsize;j++){
      if(j<6)
        LP_data[j][i] = data[j][i];
      else
        LP_data[j][i] = b[0]*data[j][i] + b[1]*data[j-1][i]+ b[2]*data[j-2][i]+b[3]*data[j-3][i]+b[4]*data[j-4][i]+b[5]*data[j-5][i];
        LP_data[j][i] = LP_data[j][i] - a[1]*LP_data[j-1][i]- a[2]*LP_data[j-2][i]- a[3]*LP_data[j-3][i]- a[4]*LP_data[j-4][i]- a[5]*LP_data[j-5][i];
    }
  }
}
