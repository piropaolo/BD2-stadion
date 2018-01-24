import javafx.application.Application;
import javafx.stage.Stage;
import javafx.util.Pair;

import java.sql.Connection;
import java.sql.SQLException;

public class Main extends Application {
    Connection connection;
    public static void main(String[] argv){
        launch();
    }

    @Override
    public void start(Stage primaryStage){
        LoginWindow loginWindow = new LoginWindow();
        Pair<String, String> loginInfo = loginWindow.setStage();
        System.out.println(loginInfo.getKey() + " " + loginInfo.getValue());
        try {
            connection = DatabaseConnection.connect(loginInfo.getKey(), loginInfo.getKey());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        if(connection == null){
            System.out.println("Connection failed");
        }
        else{
            System.out.println("Connection successful");
        }
//        primaryStage.show();
    }
}
