/**
 * Created By: Justin Smith
 * Course: CMIS 445
 * Assignment: Final Project
 * Date: 03/23/14
 */
package DBTools;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class Bootstrap {

  public static void main(String[] args) {
    String driver = "org.apache.derby.jdbc.EmbeddedDriver";
    String dbName = "BankDB";
    String URL = "jdbc:derby:" + dbName + ";create=true";

    Connection conn;

    // -- LOAD JDBC DRIVER --
    try {
      Class.forName(driver);
      System.out.println(driver + " loaded successfully!");
    } catch (ClassNotFoundException e) {
      System.err.println("Derby Embedded Driver Not Found!");
      System.err.println(e.getMessage());
    }

    // -- CONNECT TO DATABASE --
    try {
      conn = DriverManager.getConnection(URL);

      System.out.println("CONNECTED TO DATABASE " + dbName);

      // -- CHECK FOR TABLES, BUILD TABLES IF NOT PRESENT --
      try {
        if (!DBTools.checkDB(conn)) {
          buildDB(conn);
        } else {
          System.out.println("DATABASE EXIST, RETAINING DB FOR USE");
        }
      } catch (SQLException e) {
        System.err.println("Unhandled Exception from checkDB:");
        System.err.println(e.getMessage());
      }
    } catch (SQLException e) {
      System.err.println("Unhandled Exception while bootstrapping");
      System.err.println(e.getMessage());
    }
  }

  private static void buildDB(Connection conn) throws SQLException {
    Statement s = conn.createStatement();

    // -- Table Creation SQL Statements --
    String createAccountTable =
        new StringBuilder().append("CREATE TABLE ACCOUNT_T ")
            .append("( AccountID INT NOT NULL GENERATED ALWAYS AS IDENTITY ")
            .append("           ( START WITH 50000,  INCREMENT BY 7 ) ")
            .append("           CONSTRAINT Account_PK PRIMARY KEY, ")
            .append("  LastName VARCHAR(32) NOT NULL, ")
            .append("  FirstName VARCHAR(32) NOT NULL, ")
            .append("  SSN VARCHAR(11) NOT NULL, ")
            .append("  PIN CHAR(4) NOT NULL, ")
            .append("  Checking DECIMAL(12, 2) NOT NULL, ")
            .append("  Savings DECIMAL(12, 2) NOT NULL ) ")
            .toString();

    String createTransactionTable =
        new StringBuilder().append("CREATE TABLE TRANSACTION_T ")
            .append("( AccountID INT NOT NULL ")
            .append("       CONSTRAINT AccountID_FK REFERENCES Account_T ")
            .append("       ON DELETE NO ACTION ON UPDATE RESTRICT, ")
            .append(" Description VARCHAR(32) NOT NULL, ")
            .append(" AccountType VARCHAR(8) NOT NULL, ")
            .append(" Amount DECIMAL(12, 2) NOT NULL, ")
            .append(" TStamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ) ")
            .toString();

    String createUserTable =
        new StringBuilder().append("CREATE TABLE USERS_T ")
            .append("( UserID VARCHAR(12) NOT NULL ")
            .append("       CONSTRAINT UserID_PK PRIMARY KEY, ")
            .append(" UserPin CHAR(4) NOT NULL )")
            .toString();

    try {
      System.out.println("CREATING FIRST TIME DATABASE TABLES");
      System.out.println("CREATING ACCOUNT_T");
      s.execute(createAccountTable);
      System.out.println("CREATING TRANSACTION_T");
      s.execute(createTransactionTable);
      System.out.println("CREATING USERS_T");
      s.execute(createUserTable);

      // -- Create initial bank employees --
      DBTools.addUser(conn, "jsmith", "1234");
      DBTools.addUser(conn, "user", "0000");


      // -- Create initial accounts --
      DBTools.addAccount(conn, "Smith", "Justin", "123-45-6789", "1234", 5432.10, 9876.54);
      DBTools.addAccount(conn, "Sanders", "Susan", "322-98-5647", "4321", 1621.52, 546.20);
      DBTools.addAccount(conn, "Dickens", "Charles", "432-23-0098", "7363", 7654.12, 987.12);
      DBTools.addAccount(conn, "Mayer", "Steven", "874-12-9876", "1365", 123.45, 52.32);

      // -- Testing SELECT Query --
      System.out.println("Testing SELECT Query");
      BankService.Customer cust = DBTools.getAccount(conn, DBTools.getAccountID(conn, "123-45-6789"));

      if (cust == null) {
        System.out.println("ERROR ON FETCHING CUSTOMER");
      }

    } catch (SQLException e) {
      throw e;
    }
  }
}
