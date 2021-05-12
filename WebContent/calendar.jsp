<%@page import="java.util.Date"%>
<%@page import="com.koreait.myCalendar.MyCalendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달력</title>

<link rel="stylesheet" href="calendar.css">

</head>
<body>

<% 

//out.println(MyCalendar.isLeapYear(2020) + "<br/>") ; 
//out.println(MyCalendar.lastDay(2021, 2) + "<br/>") ; 
//out.println(MyCalendar.totalDay(2021, 2, 25) + "<br/>") ; 
//out.println(MyCalendar.weekDay(2021, 2, 25) + "<br/>") ; 

// 컴퓨터의 시스템의 년, 월을 얻어온다.
	Date date = new Date() ;
	int year = date.getYear() + 1900 ;
	int month = date.getMonth() + 1 ;
	
	try {
	year = Integer.parseInt(request.getParameter("year")) ;
	month = Integer.parseInt(request.getParameter("month")) ;
	
	if (month == 13) {
		month = 1 ;
		year += 1 ;
	} else if (month == 0) {
		month = 12 ;
		year -= 1 ;
	}

	} catch (NumberFormatException e) {
		
	}
%>

<table width="700" align="center" border="1" cellpadding="5" cellspacing="0">

	<tr> 
		<th>
		<!-- ?뒤에는 띄어쓰기 하면안됨, 정보는 &로 구분 -->
			<%-- <a href="?year=<%=year%>&month=<%=month-1%>">이전달</a> --%>
			<input type="button" value="이전달" onclick="location.href='?year=<%=year%>&month=<%=month-1%>'"/>
		</th>
	
		<th id="title" colspan="5"> 
			<%=year%>년 <%=month%>월
		</th>	
		
		<th>
			<%-- <a href="?year=<%=year%>&month=<%=month+1%>">다음달</a> --%>
			<input type="button" value="다음달" onclick="location.href='?year=<%=year%>&month=<%=month+1%>'"/>
		</th>
	</tr> 
	
	<tr> 
		<td class="sunday">일</td>
		<td class="etcday">월</td>
		<td class="etcday">화</td>
		<td class="etcday">수</td>
		<td class="etcday">목</td>
		<td class="etcday">금</td>
		<td class="saturday">토</td>		
	</tr>
	
	<!-- 달력에 날짜를 출력한다. -->
	<tr>
<% 
// 1일이 출력될 위치를 맞추기 위해서 1일의 요일만큼 반복하며 빈 칸을 출력한다.
//	for(int i = 1; i <= MyCalendar.weekDay(year, month, 1); i++){
//		out.println("<td>&nbsp;</td>") ;
//	}
	int week = MyCalendar.weekDay(year, month, 1) ;
	int start = 0 ;
	if (month == 1) {
		start = MyCalendar.lastDay(year - 1, 12) - week;
	} else {
		start = MyCalendar.lastDay(year, month - 1) - week ;
	}

	for(int i = 0; i < week; i++) {
			if (i == 0) {
			out.println("<td class='beforesun'>"+ (month == 1? 12 : month -1 ) + "/" + ++start +"</td>") ;
		} else {
			out.println("<td class='before'>"+ (month == 1? 12 : month -1 ) + "/" + ++start +"</td>") ;
		}
	}

// 1일부터 달력을 출력할 달의 마지막 날짜까지 반복하며 날짜를 출력한다.
	for(int i = 1; i <= MyCalendar.lastDay(year, month); i++){
		
		boolean flag = false ;
		int child = 0 ;
		if(MyCalendar.weekDay(year, 5, 5) == 6 ) {
			flag = true;
			child = 7 ;
		} else if (MyCalendar.weekDay(year, 5, 5) == 0) {
			flag = true ;
			child = 6 ;
		}
		
		if (month == 1 && i == 1) {
			out.println("<td class='holiday'>"+ i + "<br/><span>신정</span></td>") ;
		} else if (month == 3 && i == 1) {
			out.println("<td class='holiday'>"+ i + "<br/><span>삼일절</span></td>") ;
		} else if (month == 5 && i == 1) {
			out.println("<td class='holiday'>"+ i + "<br/><span>근로자의날</span></td>") ;
		} else if (month == 5 && i == 5) {
			out.println("<td class='holiday'>"+ i + "<br/><span>어린이날</span></td>") ;
		} else if (month == 6 && i == 6) {
			out.println("<td class='holiday'>"+ i + "<br/><span>현충일</span></td>") ;
		} else if (month == 8 && i == 15) {
			out.println("<td class='holiday'>"+ i + "<br/><span>광복절</span></td>") ;
		} else if (month == 10 && i == 3) {
			out.println("<td class='holiday'>"+ i + "<br/><span>개천절</span></td>") ;
		} else if (month == 10 && i == 9) {
			out.println("<td class='holiday'>"+ i + "<br/><span>한글날</span></td>") ;
		} else if (month == 12 && i == 25) {
			out.println("<td class='holiday'>"+ i + "<br/><span>크리스마스</span></td>") ;
		} else if (flag && month == 5 && i == 5) {
			out.println("<td class='holiday'>"+ i + "<br/><span>대체공휴일</span></td>") ;
		}else {
		
			
			switch (MyCalendar.weekDay(year, month, i)) {
			case 0 :
				out.println("<td class='sun'>"+ i + "</td>") ;
				break;
			case 6 :
				out.println("<td class='sat'>"+ i + "</td>") ;
				break ;
			default :
				out.println("<td class='etc'>"+ i + "</td>") ;
				break;
			
			}
		}
// 출력한 날짜가 토요일이면 줄을 바꾼다.
		if(MyCalendar.weekDay(year, month, i) == 6 && MyCalendar.lastDay(year, month) != i) {
			out.println("</tr><tr>") ;
			
		}
	}

	
%>	
	</tr>

	<tr>
		<td colspan="7">
			<form action="?" method="post">
				<select class="select" name="year">
<%
	for (int i = 1950; i <= 2050; i++) {
%>		
					<option selected="selected"><%=i%></option>
<%		
	}
%>											
				</select>년
					<select class="select" name="month">
<%
	for (int i = 1; i <= 12; i++) {
%>		
					<option><%=i%></option>
<%		
	}
%>							
			</select>월
			<input class="select" type="submit" value="보기"/>		
			</form>		
		</td>
	</tr>

</table>

</body>
</html>