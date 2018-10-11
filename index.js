const express = require("express");
const app = express();
// const bodyParser = require('body-parser');
const mongoose = require("mongoose");
const Schema = mongoose.Schema;



const postSchema = new Schema({
    title:{type:String, required:true},
    content:{type:String, required:true}
})

const Post = mongoose.model('post', postSchema);


mongoose.connect('mongodb://fan:fan@mongo:27017/myapp', { useNewUrlParser: true }).then(()=>{
    console.log('~~~~~~db connected')
}).catch(err=>{
    console.log('error~~~~~~~~~~',err)
})


app.get('/',(req,res)=>{
    res.send('<h1>hello world</h1>')
})


app.get('/addpost',(req,res)=>{
    let item = {
        title:'Post One',
        content:'this is the content for post one'
    }

    const newPost = new Post(item);
    newPost.save().then(res=>{
        console.log('~~~~~~~~res',res)
    })


    res.send('posted added')
})



app.get('/posts',(req,res)=>{
    Post.find({},(err,docs)=>{
        console.log(docs);
        res.json(docs)
    });
    

   
})

app.listen('80',()=>{
    console.log('sever started at port 80')
})