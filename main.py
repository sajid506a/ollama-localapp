from langchain_ollama.llms import OllamaLLM
from langchain_core.prompts import ChatPromptTemplate
from vector import retriever
model = OllamaLLM(model="llama3.2") 

template = """
You are an expert in answering questions about the restaurant industry. Answer the following question:
Here are some relevant reviews about the restaurant: {reviews}
Here is the question to answer: {question}

"""

prompt = ChatPromptTemplate.from_template(template)

chain = prompt | model

while True:
    print("-------------------------------------------------------------------")
    question = input("Enter your question about the restaurant (or 'exit' to q): ")
    print("\n\n")
    if question.lower() == 'exit' or question.lower() == 'q':
        break
    reviews = retriever.invoke(question)
    results = chain.invoke({"reviews": reviews, "question": question})
    print(results)