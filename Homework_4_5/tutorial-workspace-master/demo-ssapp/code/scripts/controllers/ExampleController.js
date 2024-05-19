import { CandidateDataSource } from "../datasources/CandidateDataSource.js";

const { Controller } = WebCardinal.controllers;

function getModel() {
    return {
        candidates: new CandidateDataSource()

    }
}

export default class ExampleController extends Controller {
    constructor(...props) {
        super(...props);

        // this.model = {...getModel(), name: 'John Doe'};
        this.setNavigation();

        this.model  = {
            candidate: {
                name: 'John Doe',
                votes: 0,
                image: 'https://www.w3schools.com/howto/img_avatar.png',
                party: 'Independent',
                position: 'President',
            },
        }
    }

    setNavigation () {
        const home = document.getElementById('home');

        home.addEventListener('click', () => {
            this.navigateToPageTag('home');
        });

        const myVotes = document.getElementById('my-votes');

        myVotes.addEventListener('click', () => {
            this.navigateToPageTag('my-votes');
        });

        const vote = document.getElementById('vote');

        vote.addEventListener('click', () => {
            this.navigateToPageTag('vote');
        });
    }
}
