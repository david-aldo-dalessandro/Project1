import { LightningElement, wire, track } from 'lwc';
import login from '@salesforce/apex/LoginPageController.authenticateLogin';

export default class LoginPage extends LightningElement {

    @track lData;

    @wire(login, {userName: 'Andy Young', password: 'Password'})
    loginData({error, data}){
        if(data){
            console.log(`loginPage got this data ${data}`);
            this.lData = data;
        }//end if data
        else if(error){
            console.log(`We got this error ${error}`);
        }//end if error
    }


}