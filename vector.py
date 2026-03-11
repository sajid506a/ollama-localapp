from langchain_ollama import OllamaEmbeddings
from langchain_chroma import Chroma
from langchain_core.documents import Document
import os
import pandas as pd

df = pd.read_csv("realistic_restaurant_reviews.csv")
embeddings = OllamaEmbeddings(model="mxbai-embed-large")
db_location = "./chroma_realistic_restaurant_reviews_db"
add_documents =  not os.path.exists(db_location)
if add_documents:
    documents = []
    ids=[]
    for i, row in df.iterrows():
        document = Document(
            page_content= row["Title"] + " " + row["Review"],
            metadata={"rating": row["Rating"], "date": row["Date"]}
        )
        documents.append(document)
        ids.append(str(i))
vector_store = Chroma(
    collection_name="restaurant_reviews",
    embedding_function=embeddings,
    persist_directory=db_location
    )
if add_documents:
    vector_store.add_documents(documents=documents, ids=ids)

retriever = vector_store.as_retriever(
    search_kwargs={"k": 5}
    )