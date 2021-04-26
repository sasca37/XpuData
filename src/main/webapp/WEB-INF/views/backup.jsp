
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
        getBoardList();
    });

    function getBoardList() {
        $.ajax({
            url: "/board/getBoardList",
            data: $("#boardForm").serialize(),
            dataType: "JSON",
            cache: false,
            async: true,
            type: "POST",
            success: function (obj) {
                getBoardListCallback(obj);
                console.log(obj);
            },
            error: function (xhr, status, error) {
            }

        });
    }

    function getBoardListCallback(obj) {
        var str = "";
        if (obj.length > 0) {
            for (var a = 0; a < obj.length; a++) {
                var Num = obj[a].num_cpu;
                var Cpu = obj[a].cpu;
                var Memory_FreeData = obj[a].memory_FreeData;
                var Memory_MaxData = obj[a].memory_MaxData;
                
                str += "<tr>";
                str += "<td>" + Num + "</td>";
                str += "<td>" + Cpu +"</td>";
                str += "<td>" + Memory_FreeData + "</td>";
                str += "<td>" + Memory_MaxData + "</td>";            
                str += "</tr>";
                
            }
        }

        $("#tbody").html(str);
    }
    

</script>
</head>

<body>
<form id="boardForm" name="boardForm">
    <table id="boardForm-table">
        <colgroup>
            <col width="20%"/>
            <col width="20%"/>
            <col width="30%"/>
            <col width="30%"/>
        </colgroup>
        <thead id="thead">
        <tr>
            <th>Num</th>
            <th>Cpu</th>
            <th>Memory_FreeData</th>
            <th>Memory_MaxData</th>
        </tr>
        </thead>

        <tbody id="tbody">
        </tbody>

        <tfoot id="tfoot">
        </tfoot>
    </table>
</form>

<div id="chart" class="chart" style="width: 779px; height: 300px"></div>
    <script type="text/javascript">
    //Google Stuff
    google.charts.load('current', {packages: ['corechart']});
    google.charts.setOnLoadCallback(function(){ drawChart(new_option)});
    </script>
    <script type="text/javascript">
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
        var maxValue = o.options.vAxis.maxValue;
        if(maxValue <= 1){
          value = Number((Math.random() * maxValue).toFixed(1));
        }else {
          value = Math.floor(Math.random() * maxValue);
        }
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
      
    </script>
</body>
</html>