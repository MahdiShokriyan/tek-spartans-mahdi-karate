package data;

public class GenerateData {

    public static String getEmail(){
        int number = (int) (Math.random()*99999);
        return "Jeremy"+number+ "@clone.com";
    }
}
