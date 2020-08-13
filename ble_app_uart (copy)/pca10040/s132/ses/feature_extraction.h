#include <stdio.h>
#include <stdint.h>
#include <nrf52.h>
#include "arm_const_structs.h"
#include "nrf_delay.h"
#include "nrf_gpio.h"
#include "boards.h"


#define sensors 9
#define windowsize 128
#define FFT_TEST_COMP_SAMPLES_LEN        256         //!< Complex numbers input data array size. Correspond to FFT calculation this number must be power of two starting from 2^5 (2^4
#define FFT_TEST_OUT_SAMPLES_LEN         (FFT_TEST_COMP_SAMPLES_LEN / 2) //!< Output at ray size.
#define loco_l 0
#define loco_h 5
#define freeze_l 5
#define freeze_h 15
#define SR 64


uint8_t parameter_flag = 0;
uint8_t data_flag = 0;
uint8_t thresholds_counter = 0;
float32_t thresholds[9][9];
float32_t ldas[9][9];
int thresholds_info[9]={0};
float32_t lda_info[2][9]={0};
int data[128][9] = {0};
uint8_t row=0;
uint8_t column=0;


  
static uint32_t  m_ifft_flag             = 0;
static uint32_t  m_do_bit_reverse        = 1;


struct freq_info 
{ 
   int dominant_freq; 
   float32_t sumLoco;
   float32_t sumFreeze;
   float32_t sumHP;
   float32_t freezingIndex;
};



void read_data(uint8_t* data_array,uint8_t* counter1);
void read_parameters(uint8_t* data_array,uint8_t* counter1);
void get_freq(struct freq_info* my_freq,float32_t* means);
void get_mean(float32_t* means);
void get_freq(struct freq_info* my_freq,float32_t* means);
void get_smoothness(float32_t* smoothness);
/**
 * @brief Function for processing generated sine wave samples.
 * @param[in] p_input        Pointer to input data array with complex number samples in time domain.
 * @param[in] p_input_struct Pointer to cfft instance structure describing input data.
 * @param[out] p_output      Pointer to processed data (bins) array in frequency domain.
 * @param[in] output_size    Processed data array size.
 */

static void fft_process(float32_t *                   p_input,
                        const arm_cfft_instance_f32 * p_input_struct,
                        float32_t *                   p_output,
                        uint16_t                      output_size);