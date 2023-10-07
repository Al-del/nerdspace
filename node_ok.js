const express = require('express');
const {Server} = require('ws');
const axios = require('axios');
const http = require('http');
var https = require('https');

const PORT = process.env.PORT || 3000;
const { MongoClient, ServerApiVersion } = require('mongodb');
const send = require('send');

const server = express().use((req, res) => res.send('Hello World')).listen(PORT, () => console.log('Listening on ${PORT}'));

const wss = new Server({server});

async function searchBook(name) {
    try {
        const response = await axios.get(`https://www.googleapis.com/books/v1/volumes?q=${name}`);
        const book = response.data.items[0].volumeInfo;
        const cover = book.imageLinks ? book.imageLinks.thumbnail : null;
        const author = book.authors ? book.authors[0] : null;
        const review = book.description ? book.description : null;
        console.log(cover, author, review);
       return { cover, author, review };
    } catch (error) {
        console.error(error);
    }
}


wss.on('connection', ws => {
    console.log('Client connected');
    ws.on('message', message =>{
     const buffer = Buffer.from(message);
    const text = buffer.toString();
    console.log(text);
       searchBook(text).then((data) => {
        ws.send(JSON.stringify(data));
       });
       console.log('message sent');
          getRandomBook().then((data) => {
            console.log(data.title);
        });
});
    ws.on('close', () => console.log('Client disconnected'));

});
function getRandomBook() {
    const query = 'subject:fantasy'; // You can modify this query to search for different types of books
    const url = `https://www.googleapis.com/books/v1/volumes?q=${encodeURIComponent(query)}&maxResults=40`;
    return new Promise((resolve, reject) => {
        https.get(url, (res) => {
            let data = '';
            res.on('data', (chunk) => {
                data += chunk;
            });
            res.on('end', () => {
                const result = JSON.parse(data);
                const randomIndex = Math.floor(Math.random() * result.items.length);

                const book = result.items[randomIndex];
                const title = book.volumeInfo.title;
                const author = book.volumeInfo.authors ? book.volumeInfo.authors.join(', ') : 'Unknown author';
                const coverUrl = book.volumeInfo.imageLinks ? book.volumeInfo.imageLinks.thumbnail : null;
                const rating = book.volumeInfo.averageRating || 0.0;
                resolve({ title, author, coverUrl, rating });
            });
        }).on('error', (err) => {
            reject(err);
        });
    });
}
