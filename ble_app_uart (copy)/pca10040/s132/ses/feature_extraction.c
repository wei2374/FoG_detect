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
           // printf("\r\n%d,%d:%dGNR\r\n",row,column,data[row][0]); 
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
             //nrf_delay_ms(500);
            }
          }
}

void read_parameters(uint8_t* data_array,uint8_t* counter1)
{
    int data_buffer=0;
    while(*counter1<=3){
        data_buffer|= (data_array[*counter1]&0xFF)<<((3-(*counter1))*8);
        (*counter1)++;
     }
        if(row==0){
          thresholds_info[column] = data_buffer; 
        }
        else if(row>=1 && row<=9){   
             thresholds[row-1][column] = *((float*)(&data_buffer));
             //if(row-1==7){printf("\n%d:%f",row-1,thresholds[row-1][column]);}       
        }
        else if(row>=10 && row<=11){   
             lda_info[row-10][column] = *((float*)(&data_buffer));
             //if(row-1==7){printf("\n%d:%f",row-1,thresholds[row-1][column]);}       
        }
        else{   
             ldas[row-12][column] = *((float*)(&data_buffer));
             //if(row-12==2 ||row-12==5 ||row-12==6){printf("\n%d:%f",row-12,ldas[row-12][column]);}       
        }

        (*counter1) = 0;
        column++;
        //receive a row
        if(column>8){
          column = 0;
          row++;
          //printf("\nGNT");       
          if(row==10){
           printf("\r\nGET ALL THRES\r\n");   
          }    
          if(row==12){
           printf("GET ALL LDA INFO\r\n");
           //row=0;
          }    
          if(row==21){
           printf("GET ALL LDA DATA\r\n");
            data_flag=1;
            parameter_flag=1;
            //printf(":\r>\n"); 
            row=0;
            printf("ROW is %d,COL is %d\r\n",row,column);
            nrf_delay_ms(500);          
          }
        }      
}
                      



void feature_extract()
{
  static uint8_t batch_counter=1;

  struct freq_info my_freq[sensors];
  float32_t smoothness[sensors] = {0};
  float32_t auto_corr[sensors][windowsize];
  uint8_t interval=0;  
  float32_t means[sensors] = {0};


  get_mean(means); 
  printf("\r\nThis is %d window \r\n",batch_counter);
  printf("means is %f \r\n",means[1]);
  nrf_gpio_pin_toggle(LED_2);
  get_freq(my_freq,means);
  printf("dominant frequency is %d\r\n",my_freq[1].dominant_freq);
  printf("sumLoco is %f\r\n",my_freq[1].sumLoco);
  printf("sumFreeze is %f\r\n",my_freq[1].sumFreeze);
  printf("FI is %f\r\n",my_freq[1].freezingIndex);
  nrf_gpio_pin_toggle(LED_3);
  get_smoothness(smoothness);
  printf("smoothness is %f\r\n",smoothness[1]);
  batch_counter++;
  nrf_delay_ms(500);
  nrf_gpio_pin_toggle(LED_4);
}

/**
This function is used to get the mean of test data
*/
void get_mean(float32_t* means)
{
	for(uint8_t i=0;i<sensors;i++)
	{
		for(uint8_t j=0;j<128;j++)
		{
			 means[i]+=data[j][i];
		}
                means[i] = means[i]/windowsize;
	}

}

/**
TODO:: This function will be used to extract interval from data
*/

/**
TODO:: This function will be 5 order IIR butterworth low pass filter
*/


/**
This function is used to get the smoothness of test data
*/
void get_smoothness(float32_t* smoothness)
{
	for(uint8_t sensor=0;sensor<sensors;sensor++)
	{
		for(uint8_t j=1;j<windowsize;j++)
		{
			 smoothness[sensor]+=(data[j][sensor]-data[j-1][sensor])*(data[j][sensor]-data[j-1][sensor]);
		}
	smoothness[sensor]=smoothness[sensor]/(windowsize-1); 
        }       
}

/**
This function is used to get the smoothness of test data
*/
void get_interval_and_corr(float32_t* auto_corr,uint8_t* interval)
{
	for(uint8_t sensor=0;sensor<sensors;sensor++)
	{
		for(uint8_t j=1;j<windowsize;j++)
		{
			 smoothness[sensor]+=(data[j][sensor]-data[j-1][sensor])*(data[j][sensor]-data[j-1][sensor]);
		}
	smoothness[sensor]=smoothness[sensor]/(windowsize-1); 
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
          // FI
          my_freq[sensor].freezingIndex = (my_freq[sensor].sumFreeze)/(my_freq[sensor].sumLoco);
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
