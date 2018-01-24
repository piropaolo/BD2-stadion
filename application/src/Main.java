import javafx.application.Application;
import javafx.stage.Stage;

import java.sql.SQLException;

public class Main extends Application {
    public static void main(String[] argv){
//        try {
//            DatabaseConnection.connect();
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
        launch();
    }

    @Override
    public void start(Stage primaryStage) throws Exception {
        LoginWindow loginWindow = new LoginWindow();
        loginWindow.setStage(primaryStage);
        primaryStage.show();
    }
}
