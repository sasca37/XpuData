
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
	
    </script>
    


<script type="text/javascript">
	google.charts.load('current', {packages: ['corechart']});
	google.charts.setOnLoadCallback(function(){ drawChart1(new_option)});
	google.charts.setOnLoadCallback(function(){ drawChart2(new_option)});
	google.charts.setOnLoadCallback(function(){ drawChart3(new_option)});
	
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
    
    setInterval(getXpu, 1000);
    
    var chartOption = function(target, maxValue, color, name){
        this.name = name;
        this.target = target;
        this.data = null;
        this.chart = null;
        this.options = {
          legend: { position: 'none' },
          vAxis: {minValue:0, maxValue:maxValue},
          hAxis: {
            textStyle: {
              fontSize: 11
            }
          },
          colors: [color],
          animation: {
            duration: 500,
            easing: 'in',
            startup: true
          }
        }
        
      }
    
    var new_option1 = new chartOption('chart1', 100, '#FF5E00', 'Cpu')
    var new_option2 = new chartOption('chart2', 100, '#FF5E00', 'Gpu0')
    var new_option3 = new chartOption('chart3', 100, '#FF5E00', 'Gpu1')
    

</script>
 
</head>
<body>
     <div id="chart1" class="chart1" style="width: 779px; height: 300px"></div>
     <div id="chart2" class="chart2" style="width: 779px; height: 300px"></div>
     <div id="chart3" class="chart3" style="width: 779px; height: 300px"></div>
</body>
</html>


       
       
       
       