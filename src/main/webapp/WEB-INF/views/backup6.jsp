
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>

<script type="text/javascript" src="/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery.form.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<meta charset="utf-8">

<head>
<style>
      .chart{
        border: 1px solid orange;
        float: left;
        margin: 30px;
      }
    </style>
<script type="text/javascript">
    $(document).ready(function () {
    	getCpu();
    });
  </script>

</head>

<body>
<div id="chart" class="chart" style="width: 779px; height: 300px"></div>

    <script type="text/javascript">
    
    function getCpu() {
        $.ajax({
            url: "/board/getCpu",
            data: $("#boardForm").serialize(),
            dataType: "JSON",
            cache: false,
            async: true,
            type: "POST",
            success: function (obj) {
            	getCpuCallback(obj);
                console.log(obj);
            },
            error: function (xhr, status, error) {
            }

        });
    }
	
    setInterval(getCpu, 3000);
    
    function getCpuCallback(obj) {
         var Cpu = obj.cpu;
        
         //Google Stuff
         google.charts.load('current', {packages: ['corechart']});
         google.charts.setOnLoadCallback(function(){ drawChart(new_option)});
         
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
           var new_option = new chartOption('chart', 100, '#FF5E00', 'Cpu');
           
           function drawChart(option) {
             var o = option;
             if(o != null){
               //초기값일때만 처리
               if(o.chart == null && o.data == null){
                 o.data = new google.visualization.DataTable();
                 o.data.addColumn('string', 'time');
                 o.data.addColumn('number', o.name);
                 o.data.addRow(['', 0]);
                 o.chart = new google.visualization.LineChart(document.getElementById(o.target));
               }

               o.chart.draw(o.data, o.options);
             }
           }

           function animateRenewal(option){
             var o = option;
             
             if (o.data.getNumberOfRows() >= 10) {
               o.data.removeRow(0);
             }
             var value = 0;
            
             
             value = Cpu;
             
             o.data.insertRows(o.data.getNumberOfRows(), [[getNowTime(), value]]);
             drawChart(o);
             
           }
           setInterval(function(){
               animateRenewal(new_option);
             }, 1000);
           
           function getNowTime(){
             var d = new Date();
             var sep = ":";
             var hh = d.getHours();
             var mm = d.getMinutes();
             var ss = d.getSeconds();
             return hh + sep + mm + sep + ss;
           }
                    
   }
    
    </script>
</body>
</html>


       
       
       
       