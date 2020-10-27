uint8_t bias2ones(uint8_t bias) 
{
	uint8_t unbiased;
	//yields a regulars unsigned number
	unbiased = bias + 127; 
	onesCompl = ~unbiased;
	return onesCompl; // <-- replace this with your converter
}