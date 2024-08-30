package utiles;

import com.github.javafaker.Faker;

import java.util.HashMap;
import java.util.Map;

public class FakerUtiles {
    private static final Faker faker = new Faker();
    private static final int STATIC_PINCODE = 409209;
    private static final String STATIC_COUNTRY = "India";
    public static Map<String,Object> genrateAddress(){
        Map<String,Object>address = new HashMap<>();
            address.put("addressLine1",faker.address().streetAddress());
            address.put("addressLine2",faker.address().secondaryAddress());
            address.put("city",faker.address().city());
            address.put("state",faker.address().state());
            address.put("pincode",STATIC_PINCODE);
            address.put("country",STATIC_COUNTRY);
        System.out.println("Generated address: " + address);
        return address;



    }

}
