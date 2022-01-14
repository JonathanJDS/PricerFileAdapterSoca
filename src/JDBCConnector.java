

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class JDBCConnector {


	private String sDriver = "com.mysql.cj.jdbc.Driver";
	private String sLogin;
	private String sPassword;
	private String sHostName;
	private String sPortNumber;
	private String sDatabaseName;

	private String sUrl;

	private Connection connection = null;


	

	public String getsHostName() {
		return sHostName;
	}

	public void setsHostName(String sHostName) {
		this.sHostName = sHostName;
	}

	public String getsPortNumber() {
		return sPortNumber;
	}

	public void setsPortNumber(String sPortNumber) {
		this.sPortNumber = sPortNumber;
	}

	public String getsDatabaseName() {
		return sDatabaseName;
	}

	public void setsDatabaseName(String sDatabaseName) {
		this.sDatabaseName = sDatabaseName;
	}

	public String getsDriver() {
		return sDriver;
	}

	public void setsDriver(String sDriver) {
		this.sDriver = sDriver;
	}

	public String getsUrl() {
		return sUrl;
	}

	public void setsUrl(String sUrl) {
		this.sUrl = sUrl;
	}

	public String getsLogin() {
		return sLogin;
	}

	public void setsLogin(String sLogin) {
		this.sLogin = sLogin;
	}

	public String getsPassword() {
		return sPassword;
	}

	public void setsPassword(String sPassword) {
		this.sPassword = sPassword;
	}

	public Connection getConnection() {
		return connection;
	}

	public void setConnection(Connection connection) {
		this.connection = connection;
	}

	public JDBCConnector() {


		this.sLogin = "root";
		this.sPassword = "";
		this.sHostName = "localhost";
		this.sPortNumber = "7799";
		this.sDatabaseName = "pricer";
		//this.sUrl = "jdbc:mysql://" + this.sHostName + ":" + this.sPortNumber + "/" + this.sDatabaseName + "?user="
		//		+ this.sLogin + ";password=" + this.sPassword;
		this.sUrl = "jdbc:mysql://" + this.sHostName + ":" + this.sPortNumber + "/" + this.sDatabaseName + "?user="
				+ this.sLogin + ";password=" + this.sPassword  + "?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";

		// charging pilote
		try {

			Class.forName(this.getsDriver());
			//System.out.println("Initializing JDBC driver ok....   ");

		}

		catch (ClassNotFoundException e) {
			System.out.println("Unable to initialize driver : " + this.getsDriver());
		}

	}

	public Connection connectDatabase() {

		// Connection connection = null;
		try {

			//System.out.println("connecting database : " + this.sUrl);

			this.connection = DriverManager.getConnection(this.getsUrl(), this.getsLogin(), this.getsPassword());
			//System.out.println("Database connection ok ");

		} catch (SQLException e) {

			System.out.println("unable to connect into database cause : " + e.getMessage());

			return null;

		}

		return this.connection;

	}

	public void disconnectDatabase() {

		if (this.connection != null)

			try {

				System.out.println("Trying to disconnect Database");

				this.connection.close();
				System.out.println("Database disconnected....");

			} catch (SQLException e) {

				// System.out.println("Database disconnection error : " +
				// e.getMessage());
				System.out.println("Database disconnection error : " + e.getMessage());
				e.printStackTrace();
			}

	}

}
