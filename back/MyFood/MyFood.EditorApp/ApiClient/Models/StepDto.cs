﻿// Code generated by Microsoft (R) AutoRest Code Generator 0.16.0.0
// Changes may cause incorrect behavior and will be lost if the code is
// regenerated.

namespace MyFood.EditorApp.Api.Models
{
    using System;
    using System.Linq;
    using System.Collections.Generic;
    using Newtonsoft.Json;
    using Microsoft.Rest;
    using Microsoft.Rest.Serialization;

    public partial class StepDto
    {
        /// <summary>
        /// Initializes a new instance of the StepDto class.
        /// </summary>
        public StepDto() { }

        /// <summary>
        /// Initializes a new instance of the StepDto class.
        /// </summary>
        public StepDto(string description = default(string), string voiceDescription = default(string), string pictureUrl = default(string), int? timeInSec = default(int?), string pushText = default(string), IList<string> tips = default(IList<string>))
        {
            Description = description;
            VoiceDescription = voiceDescription;
            PictureUrl = pictureUrl;
            TimeInSec = timeInSec;
            PushText = pushText;
            Tips = tips;
        }

        /// <summary>
        /// </summary>
        [JsonProperty(PropertyName = "description")]
        public string Description { get; set; }

        /// <summary>
        /// </summary>
        [JsonProperty(PropertyName = "voiceDescription")]
        public string VoiceDescription { get; set; }

        /// <summary>
        /// </summary>
        [JsonProperty(PropertyName = "pictureUrl")]
        public string PictureUrl { get; set; }

        /// <summary>
        /// </summary>
        [JsonProperty(PropertyName = "timeInSec")]
        public int? TimeInSec { get; set; }

        /// <summary>
        /// </summary>
        [JsonProperty(PropertyName = "pushText")]
        public string PushText { get; set; }

        /// <summary>
        /// </summary>
        [JsonProperty(PropertyName = "tips")]
        public IList<string> Tips { get; set; }

    }
}