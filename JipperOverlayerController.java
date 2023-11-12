package com.Jongyeol.JongyeolWeb;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@RestController()
public class JipperOverlayerController {
    private static final Pattern pattern = Pattern.compile("%\\{Multiple:(\\d+)}%");

    @GetMapping("/JipperOverlayer/Texts/{String}")
    public String textJson(@PathVariable("String") String string) throws IOException {
        String data = new String(Files.readAllBytes(Path.of("JipperOverlayer/Texts.json")));
        double i = 1;
        try {
            i = Double.parseDouble(string);
        } catch (NumberFormatException ignored) {
        }
        Matcher matcher = pattern.matcher(data);
        StringBuilder result = new StringBuilder();
        while (matcher.find()) {
            int value = Integer.parseInt(matcher.group(1));
            double newValue = i * value;
            matcher.appendReplacement(result, Double.toString(newValue));
        }
        matcher.appendTail(result);
        return result.toString();
    }

    @GetMapping("/JipperOverlayer/version")
    public String version() throws IOException {
        return Files.readString(Path.of("JipperOverlayer/version"));
    }
}
