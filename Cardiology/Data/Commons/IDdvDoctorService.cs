using System;
using System.Collections.Generic;
using Cardiology.Data.Model2;

namespace Cardiology.Data.Commons
{
    public interface IDdvDoctorService
    {
        IList<DdvDoctor> GetAll();

        IList<DdvDoctor> GetByGroupName(string groupName);

        List<DdvDoctor> GetByQuery(string sql);

        DdvDoctor GetById(string id);
    }
}
