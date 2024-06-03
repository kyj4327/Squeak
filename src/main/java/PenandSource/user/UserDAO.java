package PenandSource.user;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    DataSource dataSource;

    public UserDAO() {
        try {

            InitialContext initialContext = new InitialContext();
            Context envContext = (Context) initialContext.lookup("jav/comp/env");
            dataSource = (DataSource) envContext.lookup("jdbc/diary");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int login(String userID, String userPassword) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String SQL = "SELECT * FROM USER WHERE userID=?";
        try {

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if(rs != null) rs.close();
                if(pstmt != null) rs.close();
                if(conn !=null) conn.close();

            } catch (Exception e){
                e.printStackTrace();
            }
        }
        return -1;
    }
}