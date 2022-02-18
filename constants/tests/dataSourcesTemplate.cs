/**
  This is the definition of the Data Sources supported by Capture

  2018 © Socket Mobile, Inc. all rights reserved
*/

using System;

namespace SocketMobile
{
    namespace Capture
    {
        /// <summary>
        /// defines a symbology
        /// </summary>
        public abstract class ICaptureSymbology
        {
            /// <summary>
            /// ID of the symbology
            /// </summary>
            public abstract int ID { get; set; }
            /// <summary>
            /// Flags to know if the Param property is used
            /// </summary>
            public abstract int Flags { get; set; }
            /// <summary>
            /// Current status of a symbology
            /// </summary>
            public abstract int Status { get; set; }
            /// <summary>
            /// Parameters of a symbology (reserved for future use)
            /// </summary>
            public abstract int Param { get; set; }
            /// <summary>
            /// Name of the Symbology
            /// </summary>
            public abstract String Name { get; }

            $DATASOURCES$

            $DATASOURCESFLAGS$

            $DATASOURCESSTATUS$
          }
      }
  }
  
