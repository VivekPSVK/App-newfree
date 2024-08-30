import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.BeforeEach;

import java.nio.file.Files;
import java.nio.file.Paths;

public class testrunner {

    @BeforeEach
    public void beforeEachScenario() {
        // Ensure the file is clean before each run
        try {
            Files.deleteIfExists(Paths.get("src/test/resources/data/CreatedCouponData.json"));
            System.out.println("Cleaned up old JSON file before each scenario");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    @Karate.Test
    Karate testAllFeatures() {
        return Karate.run("classpath:feature").relativeTo(getClass());
    }
}

