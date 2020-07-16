'use strict';

const url = 'http://iactive/api/messages';

class List {
    constructor (url) {
        this.url = url;
        this.page = 1;
        this.getJson (this.url)
            .then(data => this.handlerData(data));
        this.loadNext ();
        this.loadPrev ();
    }
    getJson (url) {
        return fetch (url)
            .then (response => response.json())
            .catch(error => {
                console.log(error);
            });
    };
    // handler data, render messages
    handlerData (data) {
        document.querySelector('.comments__area').innerHTML = '';
        data.forEach(message => {
            new Message (message);
        });
    };
    loadNext () {
        
        document.querySelector('.button__next').addEventListener('click', event => {
            
            this.getJson(`${this.url}?page=${this.page + 1}`)
                .then(data => {
                    this.handlerData(data);
                    return data;
                })
                .then(data => {
                    this.page++;
                    if (this.page > 1) {
                        document.querySelector('.button__prev').classList.remove('invisible')
                    };
                    if (data.length === 0) {
                        document.querySelector('.button__next').classList.add('invisible');
                        document.querySelector('.comments__area').innerHTML = `
                            <h3 class="title">No comments</h3>
                        `;
                    };
                });
        });
    };
    loadPrev () {
        document.querySelector('.button__prev').addEventListener('click', event => {
            this.getJson(`${this.url}?page=${this.page - 1}`)
                .then(data => {
                    this.handlerData(data);
                    return data;
                })
                .then(data => {
                    this.page--;
                    if (this.page === 1) {
                        document.querySelector('.button__prev').classList.add('invisible')
                    };
                    if (data.length !== 0) {
                        document.querySelector('.button__next').classList.remove('invisible');
                    };
                });
        });
    };
};

class Message {
    constructor (message) {
        this.message = message;
        this.render();
    };
    render () {
        document.querySelector('.comments__area').insertAdjacentHTML('beforeend', `
            <div class="comments__item" >
                <div>
                    <div class="comments__datetime">
                        ${this.message.datetime} 
                    </div>
                    <div class="comments__content">
                        ${this.message.content}
                    </div>
                </div>
                <div class="comments__delete" data-message-id="${this.message.message_id}">
                    &#10060;
                </div>
            </div>
        `);
        this.delete();
    };
    delete () {
        document.querySelector('[data-message-id="' + this.message.message_id + '"]').addEventListener('click', event => {
            console.log(this.message.message_id)
            // console.log(event.target.closest('.comments__item'))
           fetch(`http://iactive/api/delete?id=${this.message.message_id}`, {
            method: 'delete'
           })
            .then(data => {
                event.target.closest('.comments__item').classList.add('invisible')
            })             
        })
    }
};



new List(url);
