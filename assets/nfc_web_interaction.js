export class NFCWebInteraction{

    isNfCSupported () {
        if ('NDEFReader' in window) {
            return JSON.stringify({data: true});
        } else {
            return JSON.stringify({data: false});
        }
    }


    async readNFC() {
        try {
            const infoData = [];
            const nfcReader = new NDEFReader();
            await nfcReader.scan();
    
            return new Promise((resolve) => {
                nfcReader.onreading = (event) => {
                    const message = event.message;
                    for (const record of message.records) {
                        console.log('Type:', record.recordType);
                        console.log('Data:', record.data);
                        infoData.push({ type: record.recordType, data: record.data });
                    }
                    resolve(JSON.stringify({ data: infoData }));
                };
            });
        } catch (error) {
            return JSON.stringify({ error: error.message });
        }
    }
    
    
}

window.nfcwebinteraction = new NFCWebInteraction();
console.log("NFCWebInteraction");