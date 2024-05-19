
const {DataSource} = WebCardinal.dataSources;


export class CandidateDataSource extends DataSource {
    constructor(...props) {
        super(...props);
        this.id = [];
        this.filter = ''; // no value = no filtering
    }

    async getPageDataAsync(startOffset, dataLengthForCurrentPage) {

        if(db === undefined){
            return [];
        }
        const data = await db.fetchData(startOffset, dataLengthForCurrentPage);
        console.log(data);
        return data;
    }
}
