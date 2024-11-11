package MyBeans;

public class Recordid
{
    public String getRecordid(String paramString, long paramLong)
	{
        String str1 = "000000000000000";
        String str2 = "0000000";
        String str3 = "00000000";

        try 
		{
            if (paramString != null && !paramString.isEmpty() && paramString.length() == 10) 
			{
                str3 = paramString.substring(0, 4) + paramString.substring(5, 7) + paramString.substring(8, 10);
            }

            str2 = String.valueOf(paramLong);

            switch (str2.length()) 
			{
                case 1:
                    str2 = "000000" + str2;
                    break;
                case 2:
                    str2 = "00000" + str2;
                    break;
                case 3:
                    str2 = "0000" + str2;
                    break;
                case 4:
                    str2 = "000" + str2;
                    break;
                case 5:
                    str2 = "00" + str2;
                    break;
                case 6:
                    str2 = "0" + str2;
                    break;
                default:
                    break;
            }

            str1 = str3 + str2;

        } catch (Exception e) 
		{
            // Handle exception if necessary
        }

        return str1;
    }
}
