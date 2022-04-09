import java.io.*;
import java.lang.*;
import java.util.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;

@SuppressWarnings("deprecation")
public class MACScraper {
	private ArrayList<String> all = new ArrayList<String>();
	private ArrayList<String> list = new ArrayList<String>();
	private ArrayList<String> gone = new ArrayList<String>();
	private ArrayList<String> prev = new ArrayList<String>();
	private ArrayList<String> temp = new ArrayList<String>();
	private String username = "root";
	private String password = "blics101";
	private String dbname = "LaptopCheckout";
	private String routerMAC = "2C:B0:5D:95:EB:C9";
	
	public MACScraper() {
		System.out.println("Initializing...");
		
		Connection connDB = null;
		
		try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            String connectionString = String.format("jdbc:mysql://localhost:3306/%s?autoReconnect=true&useSSL=false", dbname);
            connDB = DriverManager.getConnection(connectionString, username, password);
        } catch (Exception e) {
            System.out.println("DB connection error: "+ e);
        }
		
		String sqlstr = "SELECT mac FROM `laptops`";
		
        try{
            Statement stmnt = connDB.createStatement();
			            
			//System.out.println(sqlstr);
			  
			ResultSet rs = stmnt.executeQuery(sqlstr);
			  
			while (rs.next()) {
				all.add(rs.getString(1));
			}
	        connDB.close();
        } catch(Exception e){
        	e.printStackTrace();
        }
		System.out.print("All laptops: ");
        System.out.println(all);
	}
	
	private void scan() {
		ProcessBuilder processBuilder = new ProcessBuilder();
		
		System.out.println("Scanning...");

		processBuilder.command("/bin/bash","-c","echo blics101| sudo nmap -sn 192.168.1.0/24");

		try {
			
			Process process = processBuilder.start();

			StringBuilder output = new StringBuilder();

			BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));

			String line;
			while ((line = reader.readLine()) != null) {
				output.append(line + "\n");
			}

			int exitVal = process.waitFor();
			if (exitVal == 0) {
			
				String macs = output.toString();
			
				int index = 0;
				
				do {
					index = macs.indexOf("Address:") + 9;
					String temp = macs.substring(index, index + 17);
					if (!temp.equals(routerMAC) && !list.contains(temp)) list.add(temp);
					macs = macs.substring(index + 18);
				} while (macs.contains("Address"));
				
				//System.out.println(list);
			}

		} catch (IOException e) {
			e.printStackTrace();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}

	}
	
	private void update() {
		
		Connection connDB = null;
		
		try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            String connectionString = String.format("jdbc:mysql://localhost:3306/%s?autoReconnect=true&useSSL=false", dbname);
            connDB = DriverManager.getConnection(connectionString, username, password);
        } catch (Exception e) {
            System.out.println("DB connection error: "+ e);
        }

		//System.out.println(list.size());
		
		for (int i = 0; i < list.size(); i++) {
			String m = list.get(i);
			//System.out.println(m);
			String sqlstr = "UPDATE `laptops` SET `student` = NULL WHERE mac = '" + m + "'";
			
	        try{
	            Statement stmnt = connDB.createStatement();
	                      
	            //System.out.println(sqlstr);
	            if (stmnt.executeUpdate(sqlstr) > 0)
	            	System.out.println("Laptop with MAC " + m + " is available");
	            else
	            	System.out.println("Failed to insert laptop with MAC " + m + "... probably not in system");
	            
	        } catch(Exception e){
	        	e.printStackTrace();
	        }
		}
		gone.removeAll(gone);
		gone.addAll(all);
		gone.removeAll(list);
		//System.out.println("Not available: " + gone);

		String sqlstr = "SELECT student FROM userSwipe WHERE ts IN (SELECT MAX(ts) FROM userSwipe)";
		String stud = "";
		
        try{
            Statement stmnt = connDB.createStatement();
			  
			ResultSet rs = stmnt.executeQuery(sqlstr);
			while (rs.next()) {
				stud = rs.getString(1);
			}
        } catch(Exception e){
        	e.printStackTrace();
        }
        
        //System.out.println("Student: " + stud);
        
		for (int i = 0; i < gone.size(); i++) {
			String m = gone.get(i);
			sqlstr = "UPDATE `laptops` SET `student` = " + stud + " WHERE `mac` = '" + m + "' AND `student` IS NULL";
	        try{
	            Statement stmnt = connDB.createStatement();
	            if (stmnt.executeUpdate(sqlstr) > 0)
	            	System.out.println("Laptop with MAC " + m + " is checked out");
	            else
	            	System.out.println("Failed with MAC " + m);

	        } catch(Exception e){
	        	e.printStackTrace();
	        }
		}
		

        temp.removeAll(temp);
        temp.addAll(list);
        temp.removeAll(prev);
        
        if (temp.isEmpty()) {
            temp.addAll(prev);
            temp.removeAll(list);
            if (!temp.isEmpty()) {

        		sqlstr = "UPDATE `color` SET `c`='red'";
        		
                try{
                    Statement stmnt = connDB.createStatement();
        			  
        			stmnt.executeUpdate(sqlstr);
                } catch(Exception e){
                	e.printStackTrace();
                }
            }
        }
        else {

    		sqlstr = "UPDATE `color` SET `c`='red'";
    		
            try{
                Statement stmnt = connDB.createStatement();

    			stmnt.executeUpdate(sqlstr);
            } catch(Exception e){
            	e.printStackTrace();
            }
        	
        }
        
		prev.removeAll(prev);
		prev.addAll(list);
		list.removeAll(list);
		
        try {
			connDB.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
        
		
	}

	public static void main(String[] args) {
		MACScraper ms = new MACScraper();
		for (;;) {
			ms.scan();
			ms.update();
		}
	}
}
