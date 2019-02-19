using System.Collections.Generic;
using Cardiology.Data.Model2;

namespace Cardiology.Data.Commons
{
    public interface IDdtKagService
    {
        IList<DdtKag> GetAll();

        DdtKag GetById(string id);
    }
}