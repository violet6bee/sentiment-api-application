package com.example.sentiment_api;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.*;

@SpringBootApplication
@RestController
public class SentimentApiApplication {

	public static void main(String[] args) {
		SpringApplication.run(SentimentApiApplication.class, args);
	}

	@GetMapping("/api/sentiment")
	public SentimentResponse sentiment(@RequestParam String text) {
		String t = text.toLowerCase();
		String s;
		if (t.contains("good") || t.contains("great") || t.contains("happy") || t.contains("love")) s = "positive";
		else if (t.contains("bad") || t.contains("sad") || t.contains("hate") || t.contains("terrible")) s = "negative";
		else s = "neutral";
		return new SentimentResponse(s);
	}

	static class SentimentResponse {
		public String sentiment;
		public SentimentResponse(String sentiment) { this.sentiment = sentiment; }
	}
}