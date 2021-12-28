import { LightningElement} from 'lwc';

export default class WelcomeMessage extends LightningElement {
    welcome = true;
    login = false;
    products = false;

    handleWelcomeClick(){
        this.welcome = true;
        this.login = false;
        this.products = false;
    }

    handleLoginClick(){
        this.welcome = false;
        this.login = true;
        this.products = false;
    }

    handleProductsClick(){
        this.welcome = false;
        this.login = false;
        this.products = true;

    }
}