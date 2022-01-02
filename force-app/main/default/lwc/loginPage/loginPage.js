import { LightningElement, track } from 'lwc';
import login from '@salesforce/apex/LoginPageController.authenticateLogin';

export default class LoginPage extends LightningElement {

    
    @track user;
    userName = 'Username';
    password = 'Password';

    loggedOut = true;

    products = false;

    //-----------------Authentication----------------------//
    //takes in the entered username and sets it to the variable
    handleUsername(event){
        console.log('handleUsername function');
        this.userName = event.target.value;
    }

    //takes in the entered password and sets it to the variable
    handlePassword(event){
        console.log('handlePassword function');
        this.password = event.target.value;
    }

    //switches log in status to logged out
    handleLogOut(){
        this.loggedOut = true;
        this.userName = 'Enter Username Again';
        this.password = 'Enter Password Again';
    }

    //call the apex method
    handleLogin(){
        console.log('handleLogin function');

        //ensure the user name entered is not blank
        if(this.userName !== '' && this.password !== ''){
            console.log("Inside if statement");
            login({userName: this.userName, password: this.password})
                .then(result=>{
                    this.userName = result;
                    this.loggedOut = false; //creates logged in environment

                })//end then
                .catch(error =>{
                    this.loginError = error;
                    this.userName = null;
                    this.password = null;
                });

        }//end if userName
        else{
            //need some code here to show empty user name
            //this.dispatchEvent(event);
        }
    }
    ////-----------------Post Authentication Display--------///

    //conditionally renders the products page
    handleProducts(){
        this.products = true;
    }

}