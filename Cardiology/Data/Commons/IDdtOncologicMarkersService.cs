using System.Collections.Generic;
using Cardiology.Data.Model2;

namespace Cardiology.Data.Commons
{
    public interface IDdtOncologicMarkersService
    {
        IList<DdtOncologicMarkers> GetAll();

        DdtOncologicMarkers GetById(string id);
    }
}