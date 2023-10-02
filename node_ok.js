const express = require('express');
const {Server} = require('ws');
const uri = "mongodb+srv://David:DavidGI12345@nerdspaces.dl3wlsh.mongodb.net/?retryWrites=true&w=majority";

const PORT = process.env.PORT || 3000;
const { MongoClient, ServerApiVersion } = require('mongodb');
const send = require('send');

const server = express().use((req, res) => res.send('Hello World')).listen(PORT, () => console.log('Listening on ${PORT}'));

const wss = new Server({server});
const client = new MongoClient(uri, {
    serverApi: {
        version: ServerApiVersion.v1,
        strict: true,
        deprecationErrors: true,
    }
});
async function run() {
        // Connect the client to the server	(optional starting in v4.7)
        await client.connect();
        // Send a ping to confirm a successful connection
        await client.db("admin").command({ ping: 1 });
        console.log("Pinged your deployment. You successfully connected to MongoDB!");

}
run().catch(console.dir);
async function insertData(book_name) {
    const db = client.db('mydatabase'); // Replace 'mydatabase' with your database name
    const collection = db.collection('mycollection'); // Replace 'mycollection' with your collection name

    const dataToInsert = {
        key1: book_name,
    };

    try {
        const result = await collection.insertOne(dataToInsert);
        console.log('Data inserted:', result.ops);
    } catch (error) {
        console.error('Error inserting data:', error);
    }
}
async function searchData(book_name) {
    const db = client.db('mydatabase'); // Replace 'mydatabase' with your database name
    const collection = db.collection('mycollection'); // Replace 'mycollection' with your collection name

    try {
        // Define your query criteria. This example searches for documents where 'field' equals 'value'.
        const query = { book: book_name };

        // Use the 'find' method to perform the query.
        const cursor = collection.find(query);

        // Iterate through the cursor to retrieve matching documents.
        await cursor.forEach(document => {
            console.log('Matching Document:', document);
        });
    } catch (error) {
        console.error('Error searching for data:', error);
    }
}
wss.on('connection', ws => {
    console.log('Client connected');
    ws.on('message', message =>{
     const buffer = Buffer.from(message);
    const text = buffer.toString();
    console.log(text); 
});
    ws.on('close', () => console.log('Client disconnected'));

});