
void feature_extract(int* data)
{

}
void mean_and_rms(int* data)
{
	for(int i=0;i<3;i++)
	{
		for(int j=0;j<128;j++)
		{
			sum[i]+=data[j][i];
		}

		printf("\r\n %d mean is %d",i,sum[i]/128);
	}

	for(int i=0;i<9;i++)
	{
		for(int j=0;j<128;j++)
		{
			rms[i]+=(data[j][i])*(data[j][i]);
		}

		printf("\r\n %d rms is %f",i,sqrtf(rms[i]/128));
	}

}