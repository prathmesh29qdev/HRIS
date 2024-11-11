package MyBeans;
import java.io.*;
import java.util.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.StringTokenizer;
import java.text.SimpleDateFormat;

public class convertDate
{
	public convertDate(){super(); }
    public String formatDate(String sourcedate)
    {
    	String d="", m="", y="", mn="", finaldate=""; if(sourcedate.length()>0){sourcedate=sourcedate.trim();}
    	if(sourcedate.length()==10 && sourcedate.indexOf("-")==4)
    	{
	    	d=sourcedate.substring(8,10);
	    	m=sourcedate.substring(5,7);
	    	y=sourcedate.substring(0,4);
			if(m.equals("01")){mn="Jan";}
			else
			if(m.equals("02")){mn="Feb";}
			else
			if(m.equals("03")){mn="Mar";}
			else
			if(m.equals("04")){mn="Apr";}
			else
			if(m.equals("05")){mn="May";}
			else
			if(m.equals("06")){mn="Jun";}
			else
			if(m.equals("07")){mn="Jul";}
			else
			if(m.equals("08")){mn="Aug";}
			else
			if(m.equals("09")){mn="Sep";}
			else
			if(m.equals("10")){mn="Oct";}		
			else
			if(m.equals("11")){mn="Nov";}
			else
			if(m.equals("12")){mn="Dec";}
			
			finaldate=d+"-"+mn+"-"+y;
    	}
    	else
    	if(sourcedate.length()==10 && sourcedate.indexOf("-")==2)
    	{
	    	d=sourcedate.substring(0,2);
	    	m=sourcedate.substring(3,5);
	    	y=sourcedate.substring(6,10);
			if(m.equals("01")){mn="Jan";}
			else
			if(m.equals("02")){mn="Feb";}
			else
			if(m.equals("03")){mn="Mar";}
			else
			if(m.equals("04")){mn="Apr";}
			else
			if(m.equals("05")){mn="May";}
			else
			if(m.equals("06")){mn="Jun";}
			else
			if(m.equals("07")){mn="Jul";}
			else
			if(m.equals("08")){mn="Aug";}
			else
			if(m.equals("09")){mn="Sep";}
			else
			if(m.equals("10")){mn="Oct";}		
			else
			if(m.equals("11")){mn="Nov";}
			else
			if(m.equals("12")){mn="Dec";}
			
			finaldate=d+"-"+mn+"-"+y;
    	}
    	else
    	if(sourcedate.length()==10 && sourcedate.indexOf("/")==2)
    	{
	    	d=sourcedate.substring(0,2);
	    	m=sourcedate.substring(3,5);
	    	y=sourcedate.substring(6,10);
			if(m.equals("01")){mn="Jan";}
			else
			if(m.equals("02")){mn="Feb";}
			else
			if(m.equals("03")){mn="Mar";}
			else
			if(m.equals("04")){mn="Apr";}
			else
			if(m.equals("05")){mn="May";}
			else
			if(m.equals("06")){mn="Jun";}
			else
			if(m.equals("07")){mn="Jul";}
			else
			if(m.equals("08")){mn="Aug";}
			else
			if(m.equals("09")){mn="Sep";}
			else
			if(m.equals("10")){mn="Oct";}		
			else
			if(m.equals("11")){mn="Nov";}
			else
			if(m.equals("12")){mn="Dec";}
			
			finaldate=d+"-"+mn+"-"+y;
    	}
    	else
    	if(sourcedate.length()==8 && sourcedate.indexOf("/")==2)
    	{
	    	d=sourcedate.substring(0,2);
	    	m=sourcedate.substring(3,5);
	    	y=sourcedate.substring(6,8);
			if(m.equals("01")){mn="Jan";}
			else
			if(m.equals("02")){mn="Feb";}
			else
			if(m.equals("03")){mn="Mar";}
			else
			if(m.equals("04")){mn="Apr";}
			else
			if(m.equals("05")){mn="May";}
			else
			if(m.equals("06")){mn="Jun";}
			else
			if(m.equals("07")){mn="Jul";}
			else
			if(m.equals("08")){mn="Aug";}
			else
			if(m.equals("09")){mn="Sep";}
			else
			if(m.equals("10")){mn="Oct";}		
			else
			if(m.equals("11")){mn="Nov";}
			else
			if(m.equals("12")){mn="Dec";}
			
			finaldate=d+"-"+mn+"-"+y;
    	}
    	else{finaldate=sourcedate;}
		return finaldate;		
    }
    

// get Month in words

	public String getMonthName(String mn)
	{
		String month=mn;
		if(mn!=null && mn.length()>1)
		{
			if(mn.equals("01")){month="January";}
			else
			if(mn.equals("02")){month="February";}
			else
			if(mn.equals("03")){month="March";}
			else
			if(mn.equals("04")){month="April";}
			else
			if(mn.equals("05")){month="May";}
			else
			if(mn.equals("06")){month="June";}
			else
			if(mn.equals("07")){month="July";}
			else
			if(mn.equals("08")){month="August";}
			else
			if(mn.equals("09")){month="September";}
			else
			if(mn.equals("10")){month="October";}
			else
			if(mn.equals("11")){month="November";}
			else
			if(mn.equals("12")){month="December";}
		}
		return month;
	}
	
  public long timeDiffence(String paramString1, String paramString2, String paramString3, String paramString4) {
    paramString1 = paramString1 + " " + paramString3;
    paramString2 = paramString2 + " " + paramString4;
    Date date1 = null;
    Date date2 = null;
    long l1 = 0L, l2 = 0L, l3 = 0L, l4 = 0L;
    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    try {
      date1 = simpleDateFormat.parse(paramString1);
      date2 = simpleDateFormat.parse(paramString2);
      long l = date2.getTime() - date1.getTime();
      l3 = l / 3600000L;
    } catch (Exception exception) {
      exception.printStackTrace();
    } 
    return l3;
  }
  
  public long getTimeDiffrence(String paramString1, String paramString2, String paramString3, String paramString4) {
    paramString1 = paramString1 + " " + paramString3;
    paramString2 = paramString2 + " " + paramString4;
    Date date1 = null;
    Date date2 = null;
    long l1 = 0L, l2 = 0L, l3 = 0L, l4 = 0L;
    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    try {
      date1 = simpleDateFormat.parse(paramString1);
      date2 = simpleDateFormat.parse(paramString2);
      long l = date2.getTime() - date1.getTime();
      l3 = l / 3600000L;
    } catch (Exception exception) {
      exception.printStackTrace();
    } 
    return l3;
  }
  
  public long getDayDiffrence(String paramString1, String paramString2, String paramString3, String paramString4) {
    paramString1 = paramString1 + " " + paramString3;
    paramString2 = paramString2 + " " + paramString4;
    Date date1 = null;
    Date date2 = null;
    long l1 = 0L, l2 = 0L, l3 = 0L, l4 = 0L;
    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    try {
      date1 = simpleDateFormat.parse(paramString1);
      date2 = simpleDateFormat.parse(paramString2);
      long l = date2.getTime() - date1.getTime();
      l4 = l / 86400000L;
    } catch (Exception exception) {
      exception.printStackTrace();
    } 
    return l4;
  }
  
  public String nextDate(String paramString) {
    String str = "-";
    try {
      SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
      Calendar calendar = Calendar.getInstance();
      calendar.setTime(simpleDateFormat.parse(paramString));
      calendar.add(5, 1);
      str = simpleDateFormat.format(calendar.getTime());
    } catch (Exception exception) {
      exception.printStackTrace();
    } 
    return str;
  }
  
  public long getDiffMinutes(String paramString1, String paramString2, String paramString3, String paramString4) {
    paramString1 = paramString1 + " " + paramString3;
    paramString2 = paramString2 + " " + paramString4;
    Date date1 = null;
    Date date2 = null;
    long l1 = 0L, l2 = 0L, l3 = 0L, l4 = 0L;
    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    try {
      date1 = simpleDateFormat.parse(paramString1);
      date2 = simpleDateFormat.parse(paramString2);
      long l = date2.getTime() - date1.getTime();
      l2 = l / 60000L;
    } catch (Exception exception) {
      exception.printStackTrace();
    } 
    return l2;
  }
  
  public String addDays(String paramString, int paramInt) throws ParseException {
    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
    Date date = simpleDateFormat.parse(paramString);
    Calendar calendar = Calendar.getInstance();
    calendar.setTime(date);
    calendar.add(5, paramInt);
    String str = (calendar.get(1) + 1) + "-";
    if (calendar.get(2) < 10) {
      str = str + "0" + calendar.get(2) + "-";
    } else {
      str = str + calendar.get(2) + "-";
    } 
    if (calendar.get(5) < 10) {
      str = str + "0" + calendar.get(5);
    } else {
      str = str + calendar.get(5);
    } 
    return str;
  }
  
  public String substractDays(String paramString, int paramInt) throws ParseException {
    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
    Date date = simpleDateFormat.parse(paramString);
    Calendar calendar = Calendar.getInstance();
    calendar.setTime(date);
    calendar.add(5, -paramInt);
    String str = (calendar.get(1) + 1) + "-";
    if (calendar.get(2) < 10) {
      str = str + "0" + calendar.get(2) + "-";
    } else {
      str = str + calendar.get(2) + "-";
    } 
    if (calendar.get(5) < 10) {
      str = str + "0" + calendar.get(5);
    } else {
      str = str + calendar.get(5);
    } 
    return str;
  }
  
  public String getTimeFormat24(String paramString) {
    String str1 = "", str2 = "";
    str2 = paramString;
    if (str2.indexOf("PM") > 0) {
      str2 = str2.substring(0, str2.indexOf(" "));
      long l = 0L;
      StringTokenizer stringTokenizer = new StringTokenizer(str2, ":");
      try {
        while (stringTokenizer.hasMoreElements() && l < 2L) {
          if (l == 0L) {
            long l1 = Long.parseLong(stringTokenizer.nextElement().toString().trim());
            if (l1 == 12L)
              l1 -= 12L; 
            l1 += 12L;
            str1 = Long.toString(l1);
          } else if (l == 1L) {
            str1 = str1 + ":" + stringTokenizer.nextElement().toString().trim() + ":00";
          } 
          l++;
        } 
      } catch (Exception exception) {
        exception.printStackTrace();
      } 
    } else {
      str2 = str2.substring(0, str2.indexOf(" "));
      long l = 0L;
      StringTokenizer stringTokenizer = new StringTokenizer(str2, ":");
      try {
        while (stringTokenizer.hasMoreElements() && l < 2L) {
          if (l == 0L) {
            str1 = stringTokenizer.nextElement().toString().trim();
          } else if (l == 1L) {
            str1 = str1 + ":" + stringTokenizer.nextElement().toString().trim() + ":00";
          } 
          l++;
        } 
      } catch (Exception exception) {
        exception.printStackTrace();
      } 
    } 
    return str1;
  }  
    
}