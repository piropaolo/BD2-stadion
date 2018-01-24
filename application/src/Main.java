import javafx.application.Application;
import javafx.stage.Stage;
import javafx.util.Pair;

import java.sql.SQLException;

public class Main extends Application {
    public static void main(String[] argv){
        launch();
    }

    @Override
    public void start(Stage primaryStage) throws Exception {
        LoginWindow loginWindow = new LoginWindow();
        Pair<String, String> loginInfo = loginWindow.setStage();
        System.out.println(loginInfo.getKey() + " " + loginInfo.getValue());
        try {
            DatabaseConnection.connect(loginInfo.getKey(), loginInfo.getKey());
        } catch (SQLException e) {
            e.printStackTrace();
        }
//        primaryStage.show();
    }
}
