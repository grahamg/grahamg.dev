---
layout: post
title:  "Leverage Large Language Models for Better NLP Projects"
date:   2023-04-21
categories: ai nlp
---
In the landscape of Natural Language Processing (NLP), large language models (LLMs) have emerged as powerful tools capable of performing a myriad of tasks, prompting a shift in the strategies used in many NLP projects. One approach to incorporating LLMs into your NLP pipelines, termed "LLM maximalist", involves delegating all language understanding and generation tasks to a single LLM.

Although this approach holds an allure of simplicity, it comes with significant drawbacks: it's often computationally expensive and lacks modularity, making adjustments and fine-tuning a challenge.

Instead of the LLM maximalist approach, I propose an alternative: LLM pragmatism. The idea is to break down the task into separate, manageable pieces and treat the LLM as just another module in the system.

To illustrate this concept, let's walk through a Python-coded example. Suppose you are building a social media reputation management tool that summarizes mentions of your company on platforms like Twitter or Reddit.

```# Step 1: Extract mentions
def extract_mentions(posts, company):
    mentions = [post for post in posts if company in post]
    return mentions

company_mentions = extract_mentions(posts, 'your_company_name')```

The above function represents the first step in our pipeline: extracting relevant mentions of your company from a list of posts. It's a simple, deterministic function that doesn't require an LLM.

However, for the next step, determining sentiment of each mention, we might initially want to use an LLM.

```# Step 2: Determine sentiment using an LLM
def get_sentiment(texts, model):
    sentiments = [model.predict(text) for text in texts]
    return sentiments

model = SomeSentimentModel()  # this should be a pre-trained LLM, fine-tuned for sentiment analysis
sentiments = get_sentiment(company_mentions, model)```

The third step is summarizing. This is also something that could be done deterministically.

```# Step 3: Summarize
def summarize_mentions(mentions, sentiments):
    pos = [mention for mention, sentiment in zip(mentions, sentiments) if sentiment == 'positive']
    neg = [mention for mention, sentiment in zip(mentions, sentiments) if sentiment == 'negative']
    neutral = [mention for mention, sentiment in zip(mentions, sentiments) if sentiment == 'neutral']
    summary = f"Positive mentions: {len(pos)}, Negative mentions: {len(neg)}, Neutral mentions: {len(neutral)}"
    return summary

summary = summarize_mentions(company_mentions, sentiments)
print(summary)```

To further optimize this pipeline, we could train a custom model for sentiment analysis. This requires generating training data, which can be assisted by the LLM.

```# Generate training data
def generate_training_data(mentions, model):
    training_data = [(mention, model.predict(mention)) for mention in mentions]
    return training_data

training_data = generate_training_data(company_mentions, model)

# Correct the generated training data manually if needed
for i in range(len(training_data)):
    print(f"Mention: {training_data[i][0]}, Sentiment: {training_data[i][1]}")
    correct_sentiment = input("Enter the correct sentiment: ")
    training_data[i] = (training_data[i][0], correct_sentiment)```


Now, you can use this training data to train a more focused sentiment analysis model.

By following the LLM pragmatism approach, we've created an NLP pipeline that is modular, scalable, and more cost-effective, while still focusing on a robust and reliable final system.

Using LLMs in this way can help build better systems, breaking down knowledge barriers, aiding in data creation, and improving workflows. We should aim to use LLMs during development, but rely on them as little as possible during runtime, allowing us to train cheaper, faster, and more reliable replacements. This is what I believe is the best use of LLMs in modern Natural Language Processing projects.
