<%-- 
    Document   : hr
    Created on : Nov 8, 2016, 3:06:46 AM
    Author     : Harsha SlimShady
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="support.Utilities"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ADMINS | HSM</title>
        <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <style>
            #menu-list{
                margin: 0;
                height: 100%;
                background-color: #F8F8F8;
                color: #5E5E5E;
                padding: 0;
            }
            #menu-list li {
                display: block;
                font-size: 17px;
                padding: 10px;
                margin: 0;
            }
            #menu-list li:hover{
                background-color: #e5e5e5;
            }
            .menu_active{
                background-color: #e5e5e5;
            }
        </style>
        
    </head>
    <body style="font-family: 'Open Sans'">
        <%
            Integer emp_id = (Integer)session.getAttribute("emp_id");
            String emp_name = (String)session.getAttribute("emp_name");
            if(emp_id==null){
                response.sendRedirect("index.jsp");
            }
            Utilities ut = new Utilities();
            String admin_type = (String)session.getAttribute("admin_type");
            if(admin_type.equals("FOOD")) response.sendRedirect("food.jsp");
            if(admin_type.equals("HR")) response.sendRedirect("hr.jsp");
            if(admin_type.equals("SERVICES")) response.sendRedirect("services.jsp");
            if(admin_type.equals("BOOKINGS")) response.sendRedirect("bookings.jsp");
            if(admin_type.equals("COMPLAINTS")) response.sendRedirect("complaints.jsp");
            if(admin_type.equals("CAB")) response.sendRedirect("cabs.jsp");
        %>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {

        var data = google.visualization.arrayToDataTable([
          ['Department', 'no.of employees'],
          <%
          ResultSet rs = ut.getemployeeNumGroup();
          while(rs.next()){
              if(rs.next()){
                  rs.previous();
              %>
              <%="['"+rs.getString(1)+"',"+rs.getInt(2)+"],"%>
              <%
                }else{
                rs.previous();
                %>
              <%="['"+rs.getString(1)+"',"+rs.getInt(2)+"]"%>
              <%
                }
            }
          %>
        ]);

        var options = {
          title: ''
        };

        var chart = new google.visualization.PieChart(document.getElementById('piechart'));

        chart.draw(data, options);
      }
    </script>
        <nav class="navbar navbar-default navbar-fixed-top">
          <div class="container-fluid">
            <div class="navbar-header">
              <a class="navbar-brand" href="index.jsp">Hotel Management Service</a>
            </div>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#">
                    <div class="dropdown">
                    <li data-toggle="dropdown"><a><%=emp_name%> <span class="caret"></span></a></li>
                    <ul class="dropdown-menu">
                        <li><a href="logout">Logout</a></li>
                    </ul>
                    </div>
                </a></li>
            </ul>
          </div>
        </nav>
        <div class="row" style="margin-top: 51px;">
            <div class="col-md-2" id="menu-list">
                <ul style="list-style: none" >
                    <li class="menu_active"><i class="fa fa-superpowers" aria-hidden="true"></i><a href="admin.jsp"> Admin</a></li>
                    <li><i class="fa fa-id-badge" aria-hidden="true"></i><a href="bookings.jsp"> Bookings</a></li>
                    <li><i class="fa fa-cutlery" aria-hidden="true"></i><a href="food.jsp"> Food & Beverages</a></li>
                    <li><i class="fa fa-line-chart" aria-hidden="true"></i><a href="hr.jsp"> HR</a></li>
                    <li><i class="fa fa-taxi" aria-hidden="true"></i><a href="cabs.jsp"> Cabs</a></li>
                    <li><i class="fa fa-cogs" aria-hidden="true"></i><a href="services.jsp"> Services</a></li>
                    <li><i class="fa fa-info" aria-hidden="true"></i><a href="complaints.jsp"> Complaints</a></li>
                </ul>
            </div>
            <div class="col-md-10">
                <div class="col-sm-6">
                    <h4>Employees distribution</h4>
                    <div id="piechart" style="height: 500px"></div>
                </div>
            </div>
        </div>
    </body>
</html>
