//David D'Alessandro
//1/1/22
//JEST test for the login page 

import {createElement} from 'lwc'
import LoginPage from 'c/loginPage'
import login from '@salesforce/apex/LoginPageController.authenticateLogin'
import {setImmediate} from "timers"

jest.mock( '@salesforce/apex/LoginPageController.authenticateLogin',
()=> ({
    default: jest.fn()
}),
{virtual: true}
)

describe('c-login-page suite', ()=>{
    beforeEach(()=> {
        const element = createElement('c-login-page',{
            is:LoginPage
        })
    document.body.appendChild(element)
    })

    afterEach(()=> { 
        while (document.body.firstChild){
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('test return of login information', ()=>{
        const element = document.querySelector('c-login-page')

        login.mockResolvedValue({Name: 'Andy Young', Email__c: "Some Email", Phone__c: "(666) 666 6666"});

        const buttonElement = element.shadowRoot.querySelector('lightning-button')
        buttonElement.dispatchEvent(new CustomEvent('click'));

        return new Promise(setImmediate).then(()=>{
            const details = element.shadowRoot.querySelector('p.Name')
            expect(details.textContent).toBe("Andy Young")
        })
    })

    


});