
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>

<script type="text/javascript" src="/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery.form.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<meta charset="utf-8">

<head>
<style>
      .chart1{
        border: 1px solid orange;
        float: left;
        margin: 30px;
      }
      
      .chart2{
        border: 1px solid orange;
        float: left;
        margin: 30px;
      }
      
      .chart3{
        border: 1px solid orange;
        float: left;
        margin: 30px;
      }
</style>
    

    <script type="text/javascript">
    $(document).ready(function () {
        getXpu();
    });
    
    var Gpu1;
    var Gpu0;
    var Cpu;

    function getXpu() {
        $.ajax({
            url: "/xpu/getXpu",
            data: $("#xpuForm").serialize(),
            dataType: "JSON",
            cache: false,
            async: true,
            type: "POST",
            success: function (obj) {
                getXpuCallback(obj);
                console.log(obj);
            },
            error: function (xhr, status, error) {
            }

        });
    }

    function getXpuCallback(obj) {
         Gpu1 = obj[0].per;
         Gpu0 = obj[1].per;
         Cpu = obj[2].per;
        
        console.log(Gpu1);
        console.log(Gpu0);
        console.log(Cpu);
    }
</script>

<!-- 
<script type="text/javascript">
	google.charts.load('current', {packages: ['corechart']});
	google.charts.setOnLoadCallback(function(){ drawChart(new_option)});
	google.charts.setOnLoadCallback(function(){ drawChart(new_option)});
	google.charts.setOnLoadCallback(function(){ drawChart(new_option)});
</script>
 -->
</head>
<body>
     
</body>
</html>


       
       
       
       