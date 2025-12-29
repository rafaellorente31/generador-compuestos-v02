package es.hadit.generador;

import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;

public class App extends Application {
    @Override
    public void start(Stage stage) {
        try {
            ImageView logo = new ImageView(new Image(getClass().getResourceAsStream("/logo.png")));
            logo.setFitWidth(60);
            logo.setFitHeight(60);
            Label title = new Label("Generador de compuestos V01");
            Label credit = new Label("Diseñado por: hadit arquitectos s.l.p.");
            
            VBox root = new VBox(10, logo, title, credit);
            root.setStyle("-fx-alignment: center; -fx-padding: 40; -fx-background-color: #F5F5F5;");
            title.setStyle("-fx-font-family: 'Century Gothic'; -fx-font-size: 18px; -fx-font-weight: bold;");
            credit.setStyle("-fx-font-family: 'Century Gothic'; -fx-font-size: 12px; -fx-text-fill: #666;");
            
            stage.setTitle("Generador de compuestos V01 — hadit arquitectos s.l.p.");
            stage.setScene(new Scene(root, 500, 400));
            stage.show();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        launch(args);
    }
}
