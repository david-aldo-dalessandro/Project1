import { LightningElement } from 'lwc';
import {pics} from 'c/webpagePhotos'; 

export default class BannerDisplay extends LightningElement {

    banner = pics[0].image;
}