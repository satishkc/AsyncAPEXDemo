/**
 * @description       : 
 * @author            : Satish Chandrashekar
 * @group             : 
 * @last modified on  : 03-02-2021
 * @last modified by  : Satish Chandrashekar
 * Modifications Log 
 * Ver   Date         Author                 Modification
 * 1.0   03-02-2021   Satish Chandrashekar   Initial Version
**/
import { LightningElement, track, wire, api } from 'lwc';
import startRequest from '@salesforce/apexContinuation/ContinuationClass.startRequest';

export default class ContinuationTest extends LightningElement {
    @track imperativeContinuation = {};

    //Imperative Call linked to Button Click Action
    callContinuation(event){
        console.log('Invoking Controller');
        startRequest()
        .then(result => {
            this.imperativeContinuation = result;
        })
        .catch(error => {
            this.imperativeContinuation = error;
            }
        );
    }

    get formattedImperativeResult() {
    return JSON.stringify(this.imperativeContinuation);
    }
}