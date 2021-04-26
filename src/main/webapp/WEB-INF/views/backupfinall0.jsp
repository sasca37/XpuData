
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
        getXpu();
    });

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
        var str = "";
        if (obj.length > 0) {
            for (var a = 0; a < obj.length; a++) {
                
               var Time = obj[a].time;
               var Type = obj[a].type;
               var No = obj[a].no;
               var Per = obj[a].per;
            }
        }

    }
    
</script>
</head>
<body>
     
</body>
</html>


       
       
       
       