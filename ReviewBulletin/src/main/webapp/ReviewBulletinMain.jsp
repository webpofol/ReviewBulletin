<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> 
<%@ page import="ReviewModeling.PageInfo"%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/review_page.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script src="js/review_page.js"></script>

<meta charset="UTF-8">
<title>Pofol | Review</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		String id = (String) session.getAttribute("userid");
		PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
		
		int listCount=pageInfo.getListCount();
		int nowPage=pageInfo.getPage();
		int maxPage=pageInfo.getMaxPage();
		int startPage=pageInfo.getStartPage();
		int endPage=pageInfo.getEndPage();
		pageContext.setAttribute("nowPage", nowPage);
	%>
	<h2 class="headerMent"><%= id%>님 환영 합니다.</h2>
	<section id="section_wrap">
		<input type="hidden" value="<%= id%>" class="idCheck">
		<table class="reviewTable">
				<td class="tableTitle">No</td>
				<td class="tableTitle">제 목</td>
				<td class="tableTitle">작성일</td>
				<td class="tableTitle" style="width: 160px">여행지</td>
				<td class="tableTitle">평 점</td>
			<c:forEach items="${array}" var="board">
				<tr>
					<td><c:out value="${board.post_num}"/></td>
					<td class="reviewTitle">
					<a href="<c:url value='reviewSelec.pf?bNum=${board.post_num}&page=${nowPage}' />">${board.post_title}</a></td>
					<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.post_date}"/></td>
					<td class="location"><c:out value="${board.post_travel_location}"/></td>
					<c:choose>
					   <c:when test="${board.post_rating == 1.0}">
					     <td class="reviewScore"><c:out value="★✩✩✩✩"/></td>
					   </c:when>
					   <c:when test="${board.post_rating == 2.0}">
					     <td class="reviewScore"><c:out value="★★✩✩✩"/></td>
					   </c:when>
					   <c:when test="${board.post_rating == 3.0}">
					     <td class="reviewScore"><c:out value="★★★✩✩"/></td>
					   </c:when>
					   <c:when test="${board.post_rating == 4.0}">
					     <td class="reviewScore"><c:out value="★★★★✩"/></td>
					   </c:when>
					   <c:when test="${board.post_rating == 5.0}">
					     <td class="reviewScore"><c:out value="★★★★★"/></td>
					   </c:when>
					</c:choose>
				</tr>
			</c:forEach>
		</table>
		<div class="reviewWriteWrap">
			<button type="button"><a href="ReviewWritePage.jsp?user=<%= id%>&page=<%= nowPage%>" onclick="return loginCheck()">후기작성</a></button>
		</div>
	</section>
	
	<section id="pageList">
		<%if(nowPage<=1){ %>
		[이전]&nbsp;
		<%}else{ %>
		<a href="reviewPrint.pf?page=<%=nowPage-1 %>">[이전]</a>&nbsp;
		<%} %>

		<%for(int a=startPage;a<=endPage;a++){
				if(a==nowPage){%>
		[<%=a %>]
		<%}else{ %>
		<a href="reviewPrint.pf?page=<%=a %>">[<%=a %>]
		</a>&nbsp;
		<%} %>
		<%} %>

		<%if(nowPage>=maxPage){ %>
		[다음]
		<%}else{ %>
		<a href="reviewPrint.pf?page=<%=nowPage+1 %>">[다음]</a>
		<%} %>
	</section>
</body>
</html>