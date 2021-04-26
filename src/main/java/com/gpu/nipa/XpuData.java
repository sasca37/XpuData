package com.gpu.nipa;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.management.ManagementFactory;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import com.sun.management.OperatingSystemMXBean;

public class XpuData {
	Connection con = null;
	Statement stmt = null;
	String url = "jdbc:mysql://localhost/Data?serverTimezone=Asia/Seoul&useSSL=false";	
	String user = "root";
	String passwd = "nipa2021-1000";	
	static int test_num=0; //Gpu count
	static int test_num2=0;
	
/**
 * @param args
 * @throws InterruptedException
 */
public static void main(String[] args) {
	   
   XpuData db = new XpuData();
   String line;
   InputStream is;
   String GpuUsage, GpuCount;
   int GpuUsage_2=0;
   int GpuCount_2=0;
   boolean test = false; //Gpu 측정후 Cpu 측정하기 위한 변수 
	   
   // 1. GPU 성능치 
   try 
   {  
	   //데이터베이스 연결
		Class.forName("com.mysql.jdbc.Driver");
		db.con = DriverManager.getConnection(db.url, db.user, db.passwd);
		db.stmt = db.con.createStatement();
		System.out.println("Success DB Connection!");	
		//자동 커밋방지 
		db.con.setAutoCommit(false);
			try 
			{	
				//GPU 개수 확인을 위한 스크래핑
				is = Runtime.getRuntime().exec("nvidia-smi -l").getInputStream(); 
				BufferedReader br2 = new BufferedReader(new InputStreamReader(is, "MS949"));
				
				while ((line = br2.readLine()) != null) 
				{
					if (line.contains("On"))  //GPU 발견시 
					{
						test_num++; //GPU 개수 측정 변수 
					}
					if (line.contains("PID")) //모든 GPU 확인 완료시 종료 
					{
						break;
					}
				}
				
				//GPU 데이터 정보를 1초마다 출력 (nvidia-smi -l 1 무한반복)
				is = Runtime.getRuntime().exec("nvidia-smi -l 1").getInputStream(); 
				BufferedReader br = new BufferedReader(new InputStreamReader(is, "MS949"));
 
				while ((line = br.readLine()) != null) 
				{
					if (line.contains("On"))  //GPU 발견시 
					{
						GpuCount = line.substring(4,5); //해당 GPU의 장비번호 추출 (EX : 0번 GPU면 0 추출) 
						GpuCount_2 = Integer.parseInt(GpuCount.trim()); //변수 비교 및 추후 디비 저장을 위한 정수형 형변환
						test_num2++; //GPU 장비 개수가 바뀔 수 있으므로 현재 GPU 장비 개수를 저장해두는 변수
					}
					if (line.contains("%")) // 현재 GPU의 성능치 발견시
					{
						GpuUsage = line.substring(61,63); //해당 GPU의 성능치 추출 (EX : 0번 GPU의 성능치가 79%면 79 추출)
						GpuUsage_2 = Integer.parseInt(GpuUsage.trim());   // 형변환 
 
						//디비에 저장하기 위한 현재 시간
						SimpleDateFormat cal = new SimpleDateFormat ("yyyy년 MM월 dd일 HH시 mm분 ss초");
					    String format_time = cal.format(System.currentTimeMillis());
					    System.out.printf("%d번 Gpu 성능치 : %d -> %s \n",GpuCount_2,GpuUsage_2,format_time);
					    //현재시간 , 장비타입, 장비번호, 장비성능치 
					    db.insertData(format_time,'G',GpuCount_2,GpuUsage_2);
				    if (test_num == test_num2)  // 처음 스크래핑한 GPU 개수와 현재 스크래핑중인 GPU 개수가 일치 했을 경우 
				    {
				    	  test = true; //CPU 데이터 추출 시작 
				    	  test_num2=0; //현재 GPU 장비 저장 변수 0으로 초기화		    	  
			        }
				    }
					
					// 2. CPU 성능치 추출 (GPU 데이터를 모두 가져온 후에만 CPU 데이터 확인)
					if (test) 
					{
						try	{ 
							test=false;
							OperatingSystemMXBean osBean = ManagementFactory.getPlatformMXBean(OperatingSystemMXBean.class);
						    String cpu123 = String.format("%.2f", osBean.getSystemCpuLoad() * 100);
						    double cpu2 = Double.parseDouble(cpu123);
						   
						    SimpleDateFormat cal = new SimpleDateFormat ("yyyy년 MM월 dd일 HH시 mm분 ss초");
						    String format_time = cal.format(System.currentTimeMillis());
						    db.insertData_Cpu(format_time,'C',100,cpu2);
						    //CPU 성능치 출력
							System.out.println("CPU Usage : " + cpu2 +"->"+format_time);
							//GPU 개수 출력 
							System.out.println("Gpu_Count : "+test_num);
					     	System.out.println("======================================================");
					     	//CPU 데이터 추출까지 성공했을 경우에 커밋 
		        		    db.con.commit();
		        		} catch (Exception e) { 
		        			e.printStackTrace(); 
		        		} 
					}		         		   	            
		         }      
		         br.close();
		         is.close();
		         br2.close();
		      } catch (IOException e) {
		         e.printStackTrace();
		      }
   } catch(Exception e) {
	   System.out.println(e.toString());
   } finally {
	   try {
		   db.stmt.close();
		   db.con.close();				
	    } catch(Exception e) {
		System.out.println(e.toString());
	    }	
   }
}
	//GPU 데이터 db Insert
	void insertData(String time, char a, int b, int c) {
		try {
			String insertStr = "INSERT INTO xpudata VALUES('"+time+"','"+a+"',"+b+","+c+")";
			stmt.executeUpdate(insertStr);
		} catch(Exception e) {
			System.out.println(b+"번 Gpu 데이터 추가 실패 이유 : " + e.toString());
			}
	}
	
	//CPU 데이터는 성능치가 double형이므로 다른 메소드로 사용 
	void insertData_Cpu(String time, char a, int b, double c) {
		try {
			String insertStr = "INSERT INTO xpudata VALUES('"+time+"','"+a+"',"+b+","+c+")";
			stmt.executeUpdate(insertStr);
		} catch(Exception e) {
			System.out.println("Cpu 데이터 추가 실패 이유 : " + e.toString());
		}
	}
}

