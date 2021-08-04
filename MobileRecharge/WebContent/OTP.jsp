<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.Random" %>
    <%@page import="java.io.BufferedReader" %>
    <%@page import="java.io.InputStreamReader" %>
    <%@page import="java.io.OutputStreamWriter" %>
    <%@page import="java.net.URL" %>
    <%@page import="java.net.URLConnection" %>
    <%@page import="java.net.HttpURLConnection" %>
    <%@page import="javax.net.ssl.HttpsURLConnection" %>
    <%@page import="java.net.URLEncoder" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html>
<head>
<link rel="stylesheet1" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  
  
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>


<% 
String mob=(String)session.getAttribute("mobno");
int otp=1111; %>
<script>
function otpValidate()
{
	document.getElementById("home").disabled=false;
	
	<%
	
	  try
		{
	    Random rand=new Random();
		otp=rand.nextInt(9999);
		
		 String apiKey="LeUcSa75uK8rNVlPovIBgtym2jTJzkfGhRHYpwFAW1bX46nC0xKcnuO4BQdP17rwThVqDFGomSzxjN3X";
		 String number = mob;
		 String message="Hey this message is sent by using Java Code. Your OTP is :"+otp;
		
		
		String sendId="FSTSMS";
		String language="english";
		String route="p";
		
		
		
		message=URLEncoder.encode(message,"UTF-8");    //Important Step
		String myUrl="https://www.fast2sms.com/dev/bulkV2?authorization="+apiKey+"&variables_values="+otp+"&route=otp"+"&numbers="+number;

		URL url=new URL(myUrl);
		HttpsURLConnection con= (HttpsURLConnection)url.openConnection();
		
		con.setRequestMethod("GET");
		
		con.setRequestProperty("User-Agent","Mozilla/5.0");
		con.setRequestProperty("cache-control", "no-cache");
		
		int responseCode=  con.getResponseCode();
		
		StringBuffer respons=new StringBuffer();
		
		BufferedReader br=new BufferedReader(new InputStreamReader(con.getInputStream()));
		
		while(true)
		{
			String line=br.readLine();
			
			if(line==null)
			{
				break;
			}
			
			respons.append(line);
		}
		
		System.out.println(response);

		session.setAttribute("otp", otp);
		
		//response.sendRedirect("Rech.jsp");
		
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
		%>

	var no=parseInt(document.getElementById("otpp").value);
	if(no == <%=otp %>)
	{
		alert("OTP validation successful");			
	}
	else
		alert("Invalid otp entered");
		
}

</script>
</head>
<body>
<form method="post" action="Home.jsp">

	<input type="text" name="otpp" id="otpp">
	<input type="button" value="Recharge" class="btn btn-success" id="otpvalid" onclick="otpValidate()">
	
	<input type="submit" value="Home" id="home" class="btn btn-info" disabled="true">

</form>
</body>
</html>