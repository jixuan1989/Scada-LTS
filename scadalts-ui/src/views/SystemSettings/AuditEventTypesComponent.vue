<template>
  <div class="col-md-6">
    <div class="row align-items-center">
      <h2 class="col-xs-12">
        {{ $t("systemsettings.audit.title")
        }}<span v-if="isAuditEventEdited">*</span>
      </h2>
    </div>
    <div>
      <div class="row" v-for="event in auditEventTypes" v-bind:key="event.i1">
        <div class="col-xs-6">
          <p>{{ $t(event.translation) }}</p>
        </div>
        <div class="col-xs-5">
          <select
            class="form-control"
            v-model="event.i2"
            @change="watchDataChange()"
            @input="watchDataChange()"
          >
            <option v-bind:value="0">{{ $t("alarmlevels.none") }}</option>
            <option v-bind:value="1">
              {{ $t("alarmlevels.information") }}
            </option>
            <option v-bind:value="2">{{ $t("alarmlevels.urgent") }}</option>
            <option v-bind:value="3">
              {{ $t("alarmlevels.critical") }}
            </option>
            <option v-bind:value="4">
              {{ $t("alarmlevels.lifesafety") }}
            </option>
          </select>
        </div>
        <div class="col-xs-1">
          <img
            v-if="event.i2 === 1"
            src="images/flag_blue.png"
            title="Information"
            alt="Information"
          />
          <img
            v-if="event.i2 === 2"
            src="images/flag_yellow.png"
            title="Urgent"
            alt="Urgent"
          />
          <img
            v-if="event.i2 === 3"
            src="images/flag_orange.png"
            title="Critical"
            alt="Critical"
          />
          <img
            v-if="event.i2 === 4"
            src="images/flag_red.png"
            title="Life Safety"
            alt="Life Safety"
          />
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import { object } from "@amcharts/amcharts4/core";
import i18n from "../../i18n";

export default {
  name: "AuditEventTypesComponent",

  data() {
    return {
      auditEventTypes: undefined,
      auditEventTypesStore: undefined,
      isAuditEventEdited: false,
    };
  },

  mounted() {
    this.fetchData();
  },

  methods: {
    async fetchData() {
      this.auditEventTypes = await this.$store.dispatch("getAuditEventTypes");
      this.auditEventTypesStore = this.copyDataFromStore()
    },

    saveData() {
      console.log("Saved Audit!");
      this.$store.commit("setAuditEventTypes", this.auditEventTypes);
      this.auditEventTypesStore = this.copyDataFromStore();
      this.$store
        .dispatch("saveAuditEventTypes")
        .then((resp) => {
          if (resp) {
            this.restoreData();
            this.$notify({
              placement: "top-right",
              type: "success",
              content: i18n.t("systemsettings.notification.save.auditevent"),
            });
          }
        })
        .catch(() => {
          this.$notify({
            placement: "top-right",
            type: "danger",
            content: i18n.t("systemsettings.notification.fail"),
          });
        });
    },

    restoreData() {
      console.log("Restored Audit!");
      this.fetchData();
      this.isAuditEventEdited = false;
    },

    copyDataFromStore() {
      return JSON.parse(
        JSON.stringify(this.$store.state.systemSettings.auditEventTypes)
      );
    },

    async watchDataChange() {
      this.isAuditEventEdited = await this.isDataChanged();
      this.emitData(this.isAuditEventEdited);
    },

    async isDataChanged() {
      for (let i = 0; i < this.auditEventTypes.length; i++) {
        if (
          !(await this.$store.dispatch("configurationEqual", {
            object1: this.auditEventTypes[i],
            object2: this.auditEventTypesStore[i],
          }))
        )
          return true;
      }
      return false;
    },

    emitData(changed) {
      this.$emit("changed", {
        component: "auditEventTypesComponent",
        title: "systemsettings.audit.title",
        changed: changed,
        data: this.sumarizeDataChanges(),
      });
    },

    sumarizeDataChanges() {
      let data = [];
      for (let i = 0; i < this.auditEventTypes.length; i++) {
        if (this.auditEventTypes[i].i2 !== this.auditEventTypesStore[i].i2) {
          data.push({
            label: this.auditEventTypes[i].translation,
            originalData: this.convertInfoLevel(
              this.auditEventTypesStore[i].i2
            ),
            changedData: this.convertInfoLevel(this.auditEventTypes[i].i2),
          });
        }
      }
      return data;
    },

    convertInfoLevel(value) {
      switch (Number(value)) {
        case 0:
          return i18n.t("alarmlevels.none");
          break;
        case 1:
          return i18n.t("alarmlevels.information");
          break;
        case 2:
          return i18n.t("alarmlevels.urgent");
          break;
        case 3:
          return i18n.t("alarmlevels.critical");
          break;
        case 4:
          return i18n.t("alarmlevels.lifesafety");
          break;
      }
      return value;
    },
  },
};
</script>
<style>
</style>