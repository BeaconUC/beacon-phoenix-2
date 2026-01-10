<script setup>
import { ref, computed, shallowRef } from 'vue';
import { useLiveVue, useLiveForm, useLiveNavigation, useLiveEvent } from 'live_vue';
import DataTable from 'primevue/datatable';
import Column from 'primevue/column';
import InputText from 'primevue/inputtext';
import Tag from 'primevue/tag';
import Button from 'primevue/button';
import Select from 'primevue/select';
import { watch } from 'vue';

const props = defineProps({
    reports: { type: Array, required: true },
    form: { type: Object, required: true }
});

const live = useLiveVue();
const form = useLiveForm(() => props.form, {
    changeEvent: 'validate',
    submitEvent: 'save',
    debounceInMiliseconds: 200
});

const reportStatusOptions = [
    { label: 'Unprocessed', value: 'unprocessed' },
    { label: 'Processed (Outage)', value: 'processed_as_part_of_outage' },
    { label: 'Processed (Isolated)', value: 'processed_as_isolated' },
    { label: 'Archived', value: 'archived' }
];

const { navigate } = useLiveNavigation();

const dt = ref();
const editingRows = ref([]);
const selectedReports = ref([]);

const exportCSV = () => {
    dt.value.exportCSV({ selectionOnly: selectedReports.value.length > 0 });
};

const statusField = form.field('status');
const onRowEditInit = (event) => {
    if (editingRows.value.length > 1) {
        editingRows.value = [event.data];
    }
    live.pushEvent("edit_row", { id: event.data.id });
};
const onRowEditSave = async () => {
    await form.submit();
};

const searchableReports = computed(() => props.reports.map(report => ({
    ...report,
    display_date: new Date(report.created_at).toLocaleString('en-PH', { dateStyle: 'medium', timeStyle: 'short' }),
    display_status: report.status.toString(),
    display_coords: report.location ? `${report.location.coordinates[1].toFixed(4)}, ${report.location.coordinates[0].toFixed(4)}` : 'N/A',
    short_id: `${report.public_id.split('-')[0]}...`
})));

const filters = ref({ global: { value: null, matchMode: 'contains' } });
const globalFields = ['description', 'public_id', 'display_status', 'display_date', 'display_coords'];
const getSeverity = (status) => ({ unprocessed: 'danger', investigating: 'warn', resolved: 'success' }[status] || 'info');
</script>

<template>
    <div class="card shadow-sm h-full flex flex-col">
        <DataTable 
            v-model:filters="filters"
            v-model:selection="selectedReports"
            v-model:editingRows="editingRows"

            :value="searchableReports" 
            :globalFilterFields="globalFields"
            dataKey="id"
            ref="dt"
            editMode="row"
            @row-edit-init="onRowEditInit"
            @row-edit-save="onRowEditSave"
            
            scrollable 
            scrollHeight="flex" 
            :virtualScrollerOptions="{ itemSize: 50 }"
            selectionMode="multiple"
            
            stripedRows
            removableSort
            sortMode="multiple"
            resizableColumns
            showGridLines
            rowHover
            class="flex-1 cursor-pointer text-sm"
        >
            <template #header>
                <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4 px-4 py-3">
                    <div>
                        <h2 class="text-xl font-bold">Outage Report Logs</h2>
                        <div class="text-xs font-medium opacity-60">
                            {{ searchableReports.length }} Reports Loaded | {{ selectedReports.length }} Selected
                        </div>
                    </div>
                    <div class="flex items-center gap-3">
                        <span class="relative">
                            <i class="pi pi-search absolute left-3 top-1/2 -translate-y-1/2 opacity-50" />
                            <InputText v-model="filters.global.value" placeholder="Global Search..." class="pl-10 h-9 w-64 md:w-80" />
                        </span>
                        
                        <Button 
                            label="Export CSV" 
                            @click="exportCSV" 
                            size="small"
                            :disabled="searchableReports.length === 0 || selectedReports.length === 0"
                        />
                    </div>
                </div>
            </template>

            <Column selectionMode="multiple" headerStyle="width: 3rem"></Column>
            <Column field="short_id" header="ID" class="font-mono text-xs" style="width: 10%; height: 50px" />
            <Column field="description" header="Description" style="width: 40%; height: 50px" />
            <Column field="status" sortable header="Status">
                <template #body="{ data }">
                    <Tag :value="data.status" :severity="getSeverity(data.status)" />
                </template>
                <template #editor>
                    <div class="flex flex-col gap-1">
                        <Select 
                            v-model="statusField.value.value" 
                            :options="reportStatusOptions" 
                            optionLabel="label" 
                            optionValue="value" 
                            :invalid="statusField.isTouched.value && !!statusField.errorMessage.value"
                            @blur="statusField.blur()"
                            fluid 
                        />
                        <small v-if="statusField.isTouched.value && statusField.errorMessage.value" class="text-red-500">
                            {{ statusField.errorMessage.value }}
                        </small>
                    </div>
                </template>
            </Column>
            <Column field="display_coords" header="Coordinates" style="width: 20%; height: 50px" />
            <Column field="display_date" header="Time" sortable style="width: 20%; height: 50px" />
            <Column :rowEditor="true" headerStyle="width: 7rem" bodyStyle="text-align:center"></Column>

            <template #empty>
                <div class="p-10 text-center opacity-50">No reports match your query.</div>
            </template>
        </DataTable>
    </div>
</template>