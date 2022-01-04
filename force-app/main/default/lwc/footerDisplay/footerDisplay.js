import { LightningElement } from 'lwc';
import {pics} from 'c/webpagePhotos'; 

export default class FooterDisplay extends LightningElement {

    footer = pics[1].image;
}