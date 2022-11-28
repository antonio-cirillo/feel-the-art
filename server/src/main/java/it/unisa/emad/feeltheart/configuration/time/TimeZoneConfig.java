package it.unisa.emad.feeltheart.configuration.time;

import org.springframework.context.annotation.Configuration;

import javax.annotation.PostConstruct;
import java.util.TimeZone;

/**
 * Time zone configuration for the application.
 */
@Configuration
public class TimeZoneConfig {

    /**
     * Sets the default time zone to CET.
     */
    @PostConstruct
    public void init() {
        TimeZone.setDefault(TimeZone.getTimeZone("CET"));
    }
}
