import { LightningElement, track, wire } from 'lwc';
import contactPhoto from '@salesforce/apex/ContactCardController.GetContactPhoto';
import {pics} from 'c/contactPhotos'; 



export default class WireGetRecordDynamicContact extends LightningElement {
    @track error;
    @track data;
    @track cData = [];
   

    @wire(contactPhoto)
    contactFunction({error, data}){
        if(data){
            console.log(`contactCard got this data ${data}`);
            for(let i = 0; i < data.length; i++){
                for(let j = 0; j < pics.length; j++){ 
                    if(data[i].Name === pics[j].name){   
                        this.cData.push({id: data[i].Id, name: data[i].Name, title: data[i].Title, email: data[i].Email, phone: data[i].Phone, picture: pics[j].image});
                    }//end if data.Name
                }//end for j
            }//end for i
        }//end if data
        else if(error){
            console.log(`We got this error ${error}`);
        }//end if error
    }
   
}